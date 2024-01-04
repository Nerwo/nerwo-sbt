// SPDX-License-Identifier: MIT
/**
 *  @title NerwoSBT
 *  @author Gianluigi Tiesi <sherpya@gmail.com>
 *
 *                         ////////                 ////////
 *                       ////////////             ////////////
 *                       /////////////            ////////////
 *                       //////////////           ////////////
 *                         /////////////            ////////
 *                              ,/////////
 *                                    /////*
 *                                       /////
 *                                         //////
 *                                           /////////,
 *                         ////////            /////////////
 *                       ////////////           //////////////
 *                      ,////////////            /////////////
 *                       ////////////             ////////////
 *                         ////////                 ////////
 *
 *  @notice Nerwo Work Certification SoulBound Token
 */

pragma solidity ^0.8.23;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact sherpya@gmail.com
contract NerwoSBT is ERC721, ERC721URIStorage, Ownable {
    error SoulBoundToken();

    constructor()
        ERC721("Nerwo SoulBound Token", "NerwoSBT")
        Ownable(_msgSender())
    {}

    function safeMint(
        address to,
        uint256 tokenId,
        string memory uri
    ) public onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    /* To be removed after moving away from testnet */
    function setTokenURI(
        uint256 tokenId,
        string memory uri
    ) external onlyOwner {
        _setTokenURI(tokenId, uri);
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal virtual override returns (address) {
        address previousOwner = super._update(to, tokenId, auth);
        // no need to check from before, since when simulation fails no gas is spent
        if (previousOwner != address(0)) {
            revert SoulBoundToken();
        }
        return previousOwner;
    }
}
