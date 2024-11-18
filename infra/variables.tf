variable "bucket_name" {
  description = "The name of the S3 bucket for storing generated images"
  type        = string
  default     = "pgr301-couch-explorers"
}

variable "candidate_number" {
  description = "Candidate number for image storage prefix"
  type        = string
  default     = "3"
}
variable "notification_email" {
  description = "The email address to receive CloudWatch alarm notifications"
  type        = string
  default     = "noahhaile1@gmail.com"
}

