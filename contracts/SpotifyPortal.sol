// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract SpotifyPortal {
    uint256 totalPlaylists;

    event NewPlaylist(address indexed from, string message, string forwho, uint256 timestamp);

    struct Playlist{
        address mixer; // Address of user who dropped mixtape.
        string mixtape; // the link to the playlist
        string forwho; // for mom for dad for whoever
        uint256 timestamp; // timestamp when the user added playlist 
    }

    //playlists is an array of structs, will hold all playlists anyone sends me. 
    Playlist[] playlists; 

    constructor() {
        console.log("Contract Initialized!");
    }

    function drop(string memory _playlistlink, string memory _forWho) public {
        totalPlaylists += 1;
        console.log("%s has dropped their mixtape!", msg.sender);

        //Store the message in our playlists array 
        playlists.push(Playlist(msg.sender, _playlistlink, _forWho, block.timestamp));

        //tell caller what's going on
        emit NewPlaylist(msg.sender, _playlistlink, _forWho, block.timestamp);
    }

    //Get our playlist count
    function getTotalPlaylists() public view returns (uint256) {
        console.log("We have %d playlists!", totalPlaylists);
        return totalPlaylists;
    }

    //function to grab our array of playlists 
    function getAllPlaylists() public view returns (Playlist[] memory){
        return playlists;
    }

}