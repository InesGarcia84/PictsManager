from transformers import ResNetForImageClassification

finetuned_model = ResNetForImageClassification.from_pretrained("./resnet-50-cifar100-custom-beans")

finetuned_model.push_to_hub("resnet-50-cifar100-custom")