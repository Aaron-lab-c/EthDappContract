// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction{
        fallback() external payable {} //退回主幣
        receive() external payable {}

        mapping(address => Product[]) public mapproduct;
        Product[] public array_product;

        struct Product {
            string product_name;
            string product_introduce;
            uint product_price;
            address owner;
            uint index;
        }
        address payable ADMIN;
        constructor(){
            ADMIN = payable(msg.sender);
        }
        function GetProduct(uint _index) view external returns(Product memory){
            return array_product[_index];
        }
        function Get_array_product() view external returns(Product[] memory){
            return array_product;
        }
        //PO商品
        function Post(string memory _name,string memory _introduce,uint _price) external{
            Product memory product_ = Product({
                product_name : _name,
                product_introduce : _introduce,
                product_price : _price,
                owner : msg.sender,
                index : array_product.length
             });
             mapproduct[msg.sender].push(product_);
             array_product.push(product_);
        }

        //購買
        function Buy(uint _index) external payable{
            //先把商品資訊拿出來
            Product memory product_ = array_product[_index];
            //確認買家付的錢是否足夠
            require(msg.value >= product_.product_price,"value < product_._price !");

            //把持有人設為賣家
            address payable seller = payable(product_.owner);
            uint seller_arr_len = mapproduct[seller].length;

            //轉移商品(給買家)
             product_.owner = msg.sender;
             array_product[product_.index].owner = msg.sender;
             mapproduct[msg.sender].push(product_);


            //刪除賣家的商品映射
            //把後面一個一個往前移動，最後再pop掉最後一個，也就間接刪除了_index這個索引的資料。
            for(uint i=_index; i < seller_arr_len -1 ;i++){
                mapproduct[seller][i] = mapproduct[seller][i+1];
            }
            mapproduct[seller].pop();


            //把ETH轉給賣家並收取2%手續費
            seller.transfer((msg.value*98)/100);
        }

        function withdraw() public payable{
            ADMIN.transfer(address(this).balance);
        }
}