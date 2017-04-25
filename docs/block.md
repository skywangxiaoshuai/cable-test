
# Block 商圈

## 根据名字模糊筛选商圈

    登录 +，

    request:

    get /blocks/search?q=华为

    response:

    200 ok

    {
      "data": [
        {
          "id": "2",
          "type": "blocks",
          "attributes": {
            "name": "华为科技"
          }
        },
        {
          "id": "1",
          "type": "blocks",
          "attributes": {
            "name": "华为科技"
          }
        }
      ]
    }


## 返回数据库中所有的商圈信息

	request:

	GET /blocks?page[number]=1&page[size]=5

	response:

	200 ok

	{
	  "data": [
	    {
	      "id": "1",
	      "type": "blocks",
	      "attributes": {
	        "code": "4815",
	        "name": "家乐福",
	        "description": "这是小寇的地盘"
	      }
	    },
	    {
	      "id": "2",
	      "type": "blocks",
	      "attributes": {
	        "code": "4815",
	        "name": "长泰广场",
	        "description": "这是中寇的地盘"
	      }
	    },
	    {
	      "id": "3",
	      "type": "blocks",
	      "attributes": {
	        "code": "4815",
	        "name": "东方明珠",
	        "description": "这是中寇的地盘"
	      }
	    },
	    {
	      "id": "4",
	      "type": "blocks",
	      "attributes": {
	        "code": "4815",
	        "name": "世贸大厦",
	        "description": "这是中寇的地盘"
	      }
	    },
	    {
	      "id": "5",
	      "type": "blocks",
	      "attributes": {
	        "code": "4815",
	        "name": "浦东新区",
	        "description": "这是小寇的地盘"
	      }
	    }
	  ],
	  "links": {
	    "self": "http://192.168.0.23:3000/blocks?page%5Bnumber%5D=1&page%5Bsize%5D=5",
	    "next": "http://192.168.0.23:3000/blocks?page%5Bnumber%5D=2&page%5Bsize%5D=5",
	    "last": "http://192.168.0.23:3000/blocks?page%5Bnumber%5D=2&page%5Bsize%5D=5"
	  },
	  "meta": {
	    "total-count": 10
	  }
	}


## 返回用户的商圈信息

	request:

	GET /users/:user_id/blocks?page[number]=1&page[size]=2

	response:

	200 ok

	{
	  "data": [
	    {
	      "id": "2",
	      "type": "blocks",
	      "attributes": {
	        "code": "4815",
	        "name": "川沙",
	        "description": "这是老寇的地盘"
	      }
	    },
	    {
	      "id": "3",
	      "type": "blocks",
	      "attributes": {
	        "code": "4815",
	        "name": "川沙",
	        "description": "这是老寇的地盘"
	      }
	    }
	  ]
	}

## 创建商圈

	request:

	POST /blocks

	{
	  "data": {
	    "type": "blocks",
	    "attributes": {
	    "developer_id": 2,
	    "operator_id": 5,
	    "name": "川沙",
	    "code": "4815",
	    "description": "川沙"
	    }
	  }
	}

	response:

	201 created, 422 unprocessable_entity

	{
	  "data": {
	    "id": "4",
	    "type": "blocks",
	    "attributes": {
	      "code": "4815",
	      "name": "川沙",
	      "description": "川沙",
	      "developer": {
	        "id": 2,
	        "name": "张三"
	      },
	      "operator": {
	        "id": 5,
	        "name": "王五"
	      }
	    }
	  }
	}

## 编辑商圈

	request:

	GET /blocks/:id/edit

	response:

	200 ok

	{
	  "data": {
	    "id": "4",
	    "type": "blocks",
	    "attributes": {
	      "code": "4815",
	      "name": "川沙",
	      "description": "川沙",
	      "developer": {
	        "id": 2,
	        "name": "张三"
	      },
	      "operator": {
	        "id": 5,
	        "name": "王五"
	      }
	    }
	  }
	}


	request:

	PUT /blocks/:id

	{
	  "data": {
	    "type": "blocks",
	    "attributes": {
	    "developer_id": 2,
	    "operator_id": 5,
	    "name": "川沙",
	    "code": "4815",
	    "description": "川沙"
	    }
	  }
	}

	response:

	200 ok, 422 unprocessable_entity

	{
	  "data": {
	    "id": "4",
	    "type": "blocks",
	    "attributes": {
	      "code": "4815",
	      "name": "川沙",
	      "description": "川沙",
	      "developer": {
	        "id": 2,
	        "name": "张三"
	      },
	      "operator": {
	        "id": 5,
	        "name": "王五"
	      }
	    }
	  }
	}



## 删除商圈

	request:

	DELETE /blocks/:id

	response:

	204 no_content
