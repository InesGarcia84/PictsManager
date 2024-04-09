from datasets import load_dataset
from transformers import AutoImageProcessor, ResNetForImageClassification, TrainingArguments, Trainer
import numpy as np
import torch
from PIL import Image
import io 

model_name = 'microsoft/resnet-50'

cifar_custom = load_dataset('Az-r-ow/cifar100-custom')

cifar_custom = cifar_custom['train'].train_test_split(test_size=0.1)

processor = AutoImageProcessor.from_pretrained(model_name)

def transform(example_batch):
  inputs = processor([Image.open(io.BytesIO(x['bytes'])) for x in example_batch['img']], return_tensors='pt')
  
  inputs['labels'] = example_batch['label']
  return inputs

prepared_cifar = cifar_custom.with_transform(transform)

def collate_fn(batch):
  return {
    'pixel_values': torch.stack([x['pixel_values'] for x in batch]),
    'labels': torch.tensor([x['labels'] for x in batch])
  }

metric = load("accuracy")

def compute_metrics(p):
  return metric.compute(predictions=np.argmax(p.predictions, axis=1), references=p.label_ids)

labels = cifar_custom['train'].features['label'].names

model = ResNetForImageClassification.from_pretrained(
  model_name,
  num_labels=len(labels),
  id2label={str(i): c for i, c in enumerate(labels)},
  label2id={c: str(i) for i, c in enumerate(labels)},
  ignore_mismatched_sizes=True
)

training_args = TrainingArguments(
  output_dir="./resnet-50-cifar100-custom-beans",
  per_device_train_batch_size=16,
  evaluation_strategy="steps",
  num_train_epochs=4,
  save_steps=500,
  eval_steps=500,
  logging_steps=10,
  learning_rate=2e-4,
  save_total_limit=2,
  remove_unused_columns=False,
  push_to_hub=False,
  report_to='tensorboard',
  load_best_model_at_end=True,
)

trainer = Trainer(
  model=model,
  args=training_args,
  data_collator=collate_fn,
  compute_metrics=compute_metrics,
  train_dataset=prepared_cifar["train"],
  eval_dataset=prepared_cifar["test"],
  tokenizer=processor
)

train_results = trainer.train()
trainer.save_model()
trainer.log_metrics("train", train_results.metrics)
trainer.save_metrics("train", train_results.metrics)
trainer.save_state()

metrics = trainer.evaluate(prepared_cifar['test'])
trainer.log_metrics("eval", metrics)
trainer.save_metrics("eval", metrics)