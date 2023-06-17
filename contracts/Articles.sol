// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Articles {
    struct Article {
        address author;
        string title;
        string content;
        uint commentCount;
    }
    
    struct Comment {
        address commenter;
        string content;
    }
    
    constructor(){
        lastest_article = 0;
    }
    
    mapping(uint256 => Article) public articles;
    mapping(uint256 => Comment[]) public comments;
    
    uint[] public article_index;
    uint public lastest_article;
    function publishArticle(string memory _title, string memory _content) public {
        articles[lastest_article] = Article(msg.sender, _title, _content, 0);
        article_index.push(lastest_article);
        lastest_article=lastest_article+1;
    }
    function postComment(uint256 _articleId, string memory _content) public {
        require(_articleId < lastest_article, "Invalid article ID");
        Comment memory newComment = Comment(msg.sender, _content);
        comments[_articleId].push(newComment);
        articles[_articleId].commentCount++;
    }

    function getArticle(uint256 _articleId) public view returns (Article memory) {
        require(_articleId < lastest_article, "Invalid article ID");
        Article memory article = articles[_articleId];
        return article;
    }
    
    function getArticle_index() public view returns (uint[] memory) {
        return article_index;
    }
    
    function getComment(uint256 _articleId, uint256 _commentId) public view returns (Comment memory) {
        require(_articleId < lastest_article, "Invalid article ID");
        require(_commentId < comments[_articleId].length, "Invalid comment ID");
        Comment memory comment = comments[_articleId][_commentId];
        return comment;
    }


    function getAllComment(uint256 _articleId) public view returns (Comment[] memory) {
        require(_articleId < lastest_article, "Invalid article ID");
        Comment[] memory comment = comments[_articleId];
        return comment;
    }
    

}
