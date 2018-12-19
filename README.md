#### 1. ALB設置

##### 1.1 Target Group作成

`EC2` => `Target Groups` => `Create target group` => `Target type` を `IP` にする！

##### 1.2 ALB作成

`EC2` => `Load Balancers` => `Create Load Balancer` => `ALB`
=> (中略) => `Configure Routing` => `Target Group`
=> 1.1で作ったTarget Group を指定

# デプロイ
あとは`deploy.sh` の`TARGET_GROUP` に上記で作成したTarget GroupのARNを入れてデプロイするだけ。


```
$ bash deploy.sh
```