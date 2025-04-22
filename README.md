# 🚀 靜態網站 CI/CD 工作流程與 Terraform 部署

此專案是我將之前在 GitHub 上的個人簡介轉換為靜態網站，並練習使用 **Terraform** 和 **CI/CD（GitHub Actions）** 進行自動化部署。這些工具的運用包括使用 **S3** 存儲靜態網站內容、**DynamoDB** 用於鎖定機制、**IAM 角色** 來提供所需的權限，並通過 **GitHub Actions** 實現 CI/CD。

## ⚙️ 使用的工具與技術

- **Terraform**: 用於基礎設施即代碼（IaC）部署，快速創建 AWS 資源，如 S3 存儲桶和 IAM 角色。
- **GitHub Actions**: 用於構建 CI/CD 流程，實現自動化部署，包括從 GitHub 儲存庫自動部署到 AWS S3。
- **S3 (Simple Storage Service)**: 用於存儲靜態網站的 HTML、圖片和樣式文件。
- **DynamoDB**: 用於管理鎖定，防止 CI/CD 流程中重複執行或並發部署問題。
- **IAM 角色**: 透過授予適當的權限（`AmazonDynamoDBFullAccess` 和 `AmazonS3FullAccess`），確保 GitHub Actions 有足夠的權限來操作 AWS 服務。

## ⚙️ 部署流程

1. **建立 S3 存儲桶**  
   使用 **Terraform** 創建一個公開的 S3 存儲桶來存儲靜態網站文件。

2. **配置 S3 靜態網站託管**  
   配置 S3 存儲桶以啟用靜態網站託管，設置 `index.html` 為默認文檔。

3. **配置 S3 存取權限**  
   設置 S3 存儲桶的公共存取權限，允許任何人訪問網站內容。

4. **建立 CI/CD 流程**  
   使用 **GitHub Actions** 管理 CI/CD 流程，將網站文件自動部署到 S3 存儲桶中。

## 🔧 改進與擴展

### 🖥️ DNS 設定 (使用 Route 53)

可以進一步將您的 S3 靜態網站配置與 **Route 53** 結合，使用自訂域名（例如 `www.example.com`）來訪問您的靜態網站。

### 🚀 CDN 配置 (使用 CloudFront)

為了提高網站的加載速度，您可以將 S3 存儲桶與 **CloudFront** 配合，通過 CDN 來分發靜態資源。

### 🔒 限制 S3 存儲桶為私有

為了保護您的網站資源不被公開訪問，您可以將 S3 存儲桶設為私有，只允許經過授權的用戶或服務存取。

## 📦 CI/CD 工作流程

### 1. **Checkout Repository**  
   從 GitHub 下載當前代碼庫，準備進行後續操作。

### 2. **Set up AWS Credentials**  
   配置 AWS 認證，使用指定的 IAM 角色和區域來與 AWS 服務互動。

### 3. **Install Terraform**  
   安裝 Terraform，這是用來管理和配置 AWS 基礎設施的工具。

### 4. **Initialize Terraform**  
   在 Terraform 配置目錄中執行 terraform init，這樣可以初始化 Terraform 配置，準備運行 Terraform 相關指令。

### 5. **Terraform Plan**  
   執行 terraform plan，生成要部署的基礎設施變更計劃，並且提取 GitHub Secrets 中的 `BUCKET_NAME` 變數，用來指定將要創建的 S3 存儲桶名稱。

### 6. **Debug AWS Region**  
   確認 AWS 區域設置並檢查 AWS 認證是否有效，通過執行 `aws sts get-caller-identity` 來獲取當前身份驗證的詳細信息。

### 7. **Terraform Apply**  
   執行 terraform apply，根據計劃自動應用基礎設施變更，並創建指定的 S3 存儲桶。

### 8. **Uploading Files to S3 Bucket**  
   使用 AWS CLI 上傳靜態網站內容（例如 `index.html`、`images`、`styles` 目錄）到 S3 存儲桶。

## 🛠️ GitHub Repository Secrets 設定

在 GitHub 儲存庫的 **Settings** 中，您需要設置以下 **Repository Secrets**，這樣 GitHub Actions 才能正常運行：

1. **AWS_REGION**: 您的 AWS 區域（例如 `us-east-1`）。
2. **BUCKET_NAME**: 您的 S3 存儲桶名稱，用於存儲靜態網站文件。
3. **IAM_ROLE**: 您的 AWS IAM 角色 ARN，提供 GitHub Actions 必要的 AWS 訪問權限。

## 📊 功能亮點

- **Terraform 部署**: 一鍵部署 S3 靜態網站。
- **GitHub Actions 集成**: 透過 CI/CD 自動化部署流程。
- **擴展性**: 能整合 Route 53、CloudFront 服務，提升網站的性能和安全性。


- 網站: [靜態網站連結](http://terraform-resources-github-actions-2.s3-website-us-east-1.amazonaws.com/)
