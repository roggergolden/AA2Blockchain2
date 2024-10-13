// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtNFT is ERC721, Ownable {
    uint public nextTokenId;
    mapping(uint => string) private _tokenURIs;

    constructor() ERC721("ArtNFT", "ANFT") {}

    // Función para que el dueño del contrato acuñe nuevos NFTs
    function mint(address to, string memory _tokenURI) external onlyOwner {
        uint tokenId = nextTokenId;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, _tokenURI); // Asignar metadatos (como la URL de la obra de arte)
        nextTokenId++;
    }

    // Función para establecer la URL de los metadatos
    function _setTokenURI(uint tokenId, string memory _tokenURI) internal {
        _tokenURIs[tokenId] = _tokenURI;
    }

    // Función para obtener la URL de los metadatos
    function tokenURI(uint tokenId) public view override returns (string memory) {
        return _tokenURIs[tokenId];
    }
}
