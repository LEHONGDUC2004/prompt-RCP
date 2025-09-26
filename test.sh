#!/bin/bash

# Script tạo project và upload README.md lên S3

# Hỏi tên project
read -p "Nhập tên project: " PROJECT_NAME

# Hỏi tên bucket
read -p "Nhập tên S3 bucket: " BUCKET_NAME

# Tạo folder
mkdir -p "$PROJECT_NAME"

# Tạo file README.md
cat <<EOF > "$PROJECT_NAME/README.md"
# $PROJECT_NAME
Project được tạo tự động bằng script Bash.
Ngày tạo: $(date)
EOF

echo "Đã tạo folder $PROJECT_NAME và file README.md"

# Upload lên S3
aws s3 cp "$PROJECT_NAME/README.md" "s3://$BUCKET_NAME/$PROJECT_NAME/README.md"

if [ $? -eq 0 ]; then
    echo "Upload thành công lên s3://$BUCKET_NAME/$PROJECT_NAME/README.md"
else
    echo "Upload thất bại, kiểm tra lại AWS CLI hoặc bucket name."
fi
