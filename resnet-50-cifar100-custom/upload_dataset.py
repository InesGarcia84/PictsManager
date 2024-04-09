from datasets import load_from_disk

custom_dataset = load_from_disk('./datasets/cifar100-custom')

custom_dataset.push_to_hub("cifar100-custom")