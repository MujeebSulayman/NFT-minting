// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Test {
    address public owner;
    uint256 public bookCount;

    constructor() {
        owner = msg.sender;
    }

    mapping(uint256 => StoreString) private books;

    struct StoreString {
        uint256 id;
        string name;
        string description;
        uint256 price;
    }

    function createBook(
        string memory name,
        string memory description,
        uint256 price
    ) public {
        require(bytes(name).length > 0, "Name cannot be empty");
        require(bytes(description).length > 0, "Description cannot be empty");
        require(price > 0, "Price must be greater than 0");

        books[bookCount] = StoreString({
            id: bookCount,
            name: name,
            description: description,
            price: price
        });

        bookCount++;
    }

    function getBooks() public view returns (StoreString[] memory allBooks) {
        allBooks = new StoreString[](bookCount - 1);

        for (uint256 i = 1; i < bookCount; i++) {
            allBooks[i - 1] = books[i];
        }

        return allBooks;
    }

    function getBook(uint256 id) public view returns (StoreString memory) {
        return books[id];
    }
}
