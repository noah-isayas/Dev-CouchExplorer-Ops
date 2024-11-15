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
