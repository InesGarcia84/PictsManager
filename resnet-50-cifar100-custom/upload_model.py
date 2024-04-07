from transformers import AutoModel

finetuned_model = AutoModel.from_pretrained("./resnet-50-cifar100-beans")

finetuned_model.push_to_hub("resnet-50-cifar100-coarse")