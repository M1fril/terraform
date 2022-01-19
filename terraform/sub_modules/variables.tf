variable "instance_key" {
  description = "Value of the ssh key for the EC2 instance"
  type        = string
  default     = "final_task"
}

variable "instance_ami" {
  description = "ami for linux EC2 instance"
  type        = string
  default     = "ami-08ca3fed11864d6bb"
}


