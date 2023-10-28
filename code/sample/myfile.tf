resource "local_file" "myfile" {
  filename = "hello-${count.index}.txt"
  content  = "Hello world - ${count.index}"
  count    = 5
}

resource "local_file" "myfile1" {
  for_each = {
    dev = "dev.txt"
    qa  = "qa.txt"
  }
  filename = each.value
  content  = "Hello ${each.key}"
}

resource "local_file" "myfile2" {
  for_each = toset(["1.txt", "2.txt", "3.txt"])  
  filename = each.key
  content = "Filename is ${each.key}"
}

output "filename1" {
  value = {for f in local_file.myfile: f.filename=>f.content}
}

output "filename2" {
  value = {for f in local_file.myfile1: f.filename=>f.content}
}

output "filename3" {
  value = {for f in local_file.myfile2: f.filename=>f.content}
}