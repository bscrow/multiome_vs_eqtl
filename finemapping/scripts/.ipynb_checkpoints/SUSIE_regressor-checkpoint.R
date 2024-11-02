# script.R
options(repos = c(CRAN = "https://cloud.r-project.org"))
# Load required library
if (!requireNamespace("susieR", quietly = TRUE)) {
    install.packages("susieR")
}

library(susieR)

args <- commandArgs(trailingOnly = TRUE)
dirName <- args[1]
X_dir <- args[2]
y_dir <- args[3]
weights_addr <- args[4]

print("dirName")
print(dirName)
print("weights_addr")
print(weights_addr)

# Read X and y from CSV files
X <- as.matrix(read.csv(X_dir, header=FALSE))
y <- as.vector(read.csv(y_dir, header=FALSE)[, 1])
w <- as.vector(read.csv(weights_addr, header=FALSE)[, 1])

print("shape of w")
print(length(w))
print("shape of X")
print(dim(X))
print("shape of Y")
print(length(y))

# product of X and w
gene_comp <- X %*% w
print("gene_comp")
print("dim gene comp")
print(dim(gene_comp))
print("len gene comp")
print(length(gene_comp))


# combine to get X_in
X_in <- cbind(gene_comp, X)
print("dim X_in")
print(dim(X_in))

# Run susie
res <- susie(X_in, y, L = 10)

# Assuming res is your susie object
pip <- res$pip
alpha <- res$alpha
mu <- res$mu
mu2 <- res$mu2

# Convert matrices to data frames
alpha_df <- as.data.frame(alpha)
mu_df <- as.data.frame(mu)

write.csv(pip, file = paste0(dirName, "/pip.csv"), row.names = FALSE)
write.csv(alpha_df, file = paste0(dirName, "/alpha.csv"), row.names = FALSE)
write.csv(mu_df, file = paste0(dirName, "/mu.csv"), row.names = FALSE)
write.csv(mu2, file = paste0(dirName, "/mu2.csv"), row.names = FALSE)