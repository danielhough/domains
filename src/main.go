package main

import (
	"github.com/aws/aws-lambda-go/lambda"
	"log"
)

func main() {
	lambda.Start(Handler)
}

func Handler() {
	log.Printf("Processing Lambda request")
}
