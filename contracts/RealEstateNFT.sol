// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RealEstateNFT is ERC721, Ownable {
    using Counters for Counters.Counter;

    // Contador para asignar un identificador único a cada NFT
    Counters.Counter private _tokenIdCounter;

    // Estructura para almacenar detalles de la propiedad
    struct Property {
        string name;
        string location;
        uint256 totalShares;  // Número total de fracciones de la propiedad
        uint256 sharePrice;   // Precio por fracción
    }

    // Mapeo para almacenar las propiedades asociadas a cada NFT
    mapping(uint256 => Property) public properties;

    // Evento emitido cuando se acuña un nuevo NFT de propiedad
    event PropertyMinted(address indexed owner, uint256 tokenId, string name, string location, uint256 shares, uint256 price);

    // Constructor que define el nombre y símbolo del NFT
    constructor() ERC721("RealEstateNFT", "RE-NFT") {}

    // Función para acuñar (mint) nuevos NFTs que representan una fracción de la propiedad
    function mintPropertyNFT(string memory _name, string memory _location, uint256 _totalShares, uint256 _sharePrice) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();

        // Crear la propiedad y asociarla al NFT
        properties[tokenId] = Property(_name, _location, _totalShares, _sharePrice);

        // Acuñar el NFT y asignárselo al inversor
        _mint(msg.sender, tokenId);

        // Emitir un evento cuando se crea un nuevo NFT
        emit PropertyMinted(msg.sender, tokenId, _name, _location, _totalShares, _sharePrice);
    }

    // Función para consultar los detalles de una propiedad específica
    function getPropertyDetails(uint256 tokenId) public view returns (string memory, string memory, uint256, uint256) {
        require(_exists(tokenId), "La propiedad no existe");
        Property memory property = properties[tokenId];
        return (property.name, property.location, property.totalShares, property.sharePrice);
    }

    // Función para transferir la propiedad (NFT) de una fracción entre inversores
    function transferFraction(address to, uint256 tokenId) public {
        safeTransferFrom(msg.sender, to, tokenId);
    }
}
