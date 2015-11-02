library(glmnet)

# Read data
data = read.csv("../data/train.txt",
                sep="\t",
                na.strings = "NULL",
                encoding = "UTF-8")



    

# Clean data
names(data) = paste0("V",1:16)
data = na.omit(data)
data1 = data[data[,16]>0,]

# Train and test
trainx = as.matrix(data1[,2:15])
trainy = as.matrix(data1[,16])

testx = as.matrix(data[,2:15])

# Modeling
model = glmnet(trainx ,trainy ,family = "gaussian",nlambda =4)

cat(model$beta[,2])
# Predict
predict = testx %*% model$beta[,2]
predict = predict(model,testx,2)
# 50%分数由模型得到
score1 = (predict - min(predict)) / 
    (max(predict) - min(predict)) * 50

# 10%分数为标记分数
score2 = data$V16/6.6

# 20%分数为招聘规模得分
score3 = ifelse(data$V3 > 27, 16,
                ifelse(data$V3>9, 12,
                       ifelse(data$V3>3, 8, 4)))

# 5%分数为技术比例
score4 = (data$V3 + data$V4 + data$V5) / data$V3 * 5

# 5%分数为城市分数
score5 = data$V2 * 5

# 5%分数为薪资得分
score6 = (data$V12 * 5 + data$V13 * 3)/data$V3

# 5%分数为学历得分
score7 = data$V13 * 5 + data$V14 * 3

score = score1 + score2 + score3 + score4 + score5 + score6 + score7
    
# Write the files
writedata = data.frame(company = data$V1,
                       score = score)
writedata = writedata[order(writedata[,2] ,decreasing = T),]
# Sys.setlocale("LC_CTYPE","chs")
lines = paste(apply(writedata, 1, 
                    function(x) paste0(x[1], "\t", x[2])), "\n")
writeLines(lines,"../data/1.txt",useBytes = T)
# Sys.setlocale("LC_CTYPE","eng")

