pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GeopolyNFT is ERC721Enumerable, Ownable {

    using Strings for uint256;

    // change for Geopoly Base URL
    string public baseURI = "https://geonft-dc7ae.web.app/nfts/";
    string public baseExtension = ".json";

    constructor() ERC721("GeopolyNFT", "GEO") { }

    function batchmint(uint256 _mintAmount) public onlyOwner {
        uint256 supply = totalSupply();

        for (uint256 i = 1; i <= _mintAmount; i++) {
            _safeMint(msg.sender, supply + i);
        }
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
        baseExtension = _newBaseExtension;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns(string memory) {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
    
        return bytes(baseURI).length > 0
            ? string(abi.encodePacked(baseURI, tokenId.toString(), baseExtension))
            : "";
    }

}
