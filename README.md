![stability-stable](https://img.shields.io/badge/stability-stable-green.svg)
![last-commit](https://img.shields.io/github/last-commit/imilad/infrastructure-as-code-tools)

## Tools can be used as Infrastructure as Code
Try out some IaC tools to provision EC2 instance on AWS.

**Table of Contents**
- [Workflow](#workflow)
- [Create SSH Key](#create-ssh-key)
    - [Generate SSH key](#ssh-keygen)
    - [SSH to ec2](#connect-to-ec2)
- [Terraform](#terraform)
    - [Installation](#terraform-installtion)
    - [Usage](#usage)
- [Ansible](#ansible)
    - [Installation](#ansible-installation)
    - [Configuration](#ansible-configuration)
    - [AWS Access and Secret Keys](#aws-access-and-secret-keys)
        - [Ansible Vault](#ansible-vault)
    - [Usage](#usage)
        - [Single Playbook](#single-playbook)
        - [Roles](#roles)

# Workflow
* Create EC2 instance
* Create Security Group and attach to EC2
* Generate ssh public key locally
* Upload ssh public key to AWS and attach it to EC2
* Install Docker on EC2
* Run Ngnix

# Create SSH Key 
### ssh-keygen
Generate ssh key for SSH connection, after that update `terraform.tfvars` with the correct key name and path to public key.
```shell script
$ ssh-keygen
```

### connect to ec2
```shell script
$ ssh -i ~/.ssh/<path-to-private-key> ec2-user@<EC2-IP>
```

# Terraform
### Terraform Installtion
See the official page for how to install terraform: [Install terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)

### Usage
```shell script
$ terraform plan
$ terraform apply
```

# Ansible
### Ansible Installation
See the official page for how to install: [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

### Ansible Configuration
* Set EDITOR for Ansible-Vault `export EDITOR=vim` (or any other editor)
* edit ansible.cfg and set `host_key_checking = False` to avoid host key checking otherwise Ansible cannot connect to EC2 via SSH.
* Ansible needs path to private key for SSH connection to EC2, two options are:
  1. set it in the `variables.yml`
  2. run ansible playbook with `--private-key <path-to-private-key>`

### AWS Access and Secret Keys
See .boto configuration for more options to set and use AWS tokens. [Credentials](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/configuration.html)

as default it will take it from `~/.aws/credentials`, another easy alternative is to export them, but the safest approach is to use `ansible-vault` but then you have to inject the variables into the playbook for each necessary task, like:

````yaml
- name: Upload public key to AWS
  ec2_key:
    aws_access_key: "{{ aws_access_key_id }}"
    aws_secret_key: "{{ aws_secret_access_key }}
    security_token: "{{ aws_session_token }}"
    region: "{{ region }}"
    name: "{{ key_name }}"
    key_material: "{{ lookup('file', '~/.ssh/{{ key_name }}.pub') }}"
````

#### Ansible-Vault

1. Run command below to create and encrypt content of the file, it will ask you at first for password, remember it as we need it each time we run Ansible playbook.
    ```shell script
    $ ansible-vault create keys.yml
    ```
2. copy & paste keys:
    ```yaml
    aws_access_key_id: <key>
    aws_secret_access_key: <key>
    aws_session_token: <key>
    ```

### usage

#### Single Playbook

```shell script
$ ansible-playbook -i hosts ec2.yml --tags create_ec2,configure_ec2 --ask-vault-pass
```
* First command will run ansible to get info about the running EC2.
* Second command uses tags to `create` or/and `config` EC2.

#### Roles

```shell script
$ ansible-playbook -i hosts play-role.yml
```
it will provision and configure EC2 and run Nginx docker container, after that just run below command to change or add new container.

```shell script
$ ansible-playbook -i hosts play-role.yml --tags app
```
