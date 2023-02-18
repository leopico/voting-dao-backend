// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";

contract VotingDAO {
    using Counters for Counters.Counter;

    Counters.Counter public _voterId; //take the id from Counters.sol
    Counters.Counter public _candidateId; //take the id from Counters.sol

    address public votingOrganizer;

    //Candidate's data for voting
    struct Candidate {
        uint256 candidateId;
        string age;
        string name;
        string image; //this image will be upload to the ipfs
        uint256 voteCount;
        address _address;
        string ipfs; //this will be include all the imformation of every single candidate's data that will upload to ipfs
    }

    event CandidateCreate(
        uint256 indexed candidateId,
        string age,
        string name,
        string image,
        uint256 voteCount,
        address _address,
        string ipfs
    );

    address[] public candidateAddresses; //all the addresses of the candidates will storing in this array
    mapping(address => Candidate) public candidates; //storing data of Candidate with provide the key of candidates's addresses
    //end of Candidate's data for voting

    //Voter data
    struct Voter {
        uint256 voter_voterId;
        string voter_name;
        string voter_image;
        address voter_address;
        uint256 voter_allowed;
        bool voter_voted;
        uint256 voter_vote; //this is how may candidate have in this voter_vote
        string voter_ipfs;
    }

    event VoterCreated(
        uint256 indexed voter_voterId,
        string voter_name,
        string voter_image,
        address voter_address,
        uint256 voter_allowed,
        bool voter_voted,
        uint256 voter_vote,
        string voter_ipfs
    );

    address[] public votedVoterAddresses;
    address[] public voterAddresses;
    mapping(address => Voter) public voters;

    // end of Voter data

    //this is special function while deploying
    constructor() {
        votingOrganizer = msg.sender;
    }

    //-------candidate section----------//
    function setCandidate(
        address _address,
        string memory _age,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            votingOrganizer == msg.sender,
            "only organizer can create setCandidate"
        );
        _candidateId.increment(); //this is increate +1 when create setCandidate that interface from Counters.sol
        uint256 idNumber = _candidateId.current(); //this getting current id after assigned from _candidateId.increment()
        Candidate storage candidate = candidates[_address]; //this is calling struct with mapping for Candidate that store as candidate name
        candidate.candidateId = idNumber;
        candidate.age = _age;
        candidate.name = _name;
        candidate.image = _image;
        candidate.voteCount = 0; //initially will start with 0 for voting
        candidate._address = _address;
        candidate.ipfs = _ipfs;

        candidateAddresses.push(_address); //all the candidate's addresses will push to candidateAddresses array after every single setCandidate

        //after transcation then will emit for candidateCreate
        emit CandidateCreate(
            idNumber,
            _age,
            _name,
            _image,
            candidate.voteCount,
            _address,
            _ipfs
        );
    }

    function getCandidate() public view returns (address[] memory) {
        return candidateAddresses;
    }

    function getCandidateLength() public view returns (uint256) {
        return candidateAddresses.length;
    }

    //all the data of single candidate that data getting from mapping of candidates
    function getCandidatedata(
        address _address
    )
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            string memory,
            uint256,
            address,
            string memory
        )
    {
        return (
            candidates[_address].candidateId,
            candidates[_address].age,
            candidates[_address].name,
            candidates[_address].image,
            candidates[_address].voteCount,
            candidates[_address]._address,
            candidates[_address].ipfs
        );
    }

    //-------end of candidate section----------//

    //-------voter section------------//
    function voterRight(
        address _address,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            votingOrganizer == msg.sender,
            "only organizer can create voter"
        );
        _voterId.increment();
        uint256 idNumber = _voterId.current();

        Voter storage voter = voters[_address]; //this is calling struct with mapping for Voter that store as voter name
        require(
            voter.voter_allowed == 0,
            "can not vote because of voter_allowed is not 0"
        );
        voter.voter_allowed = 1; //this stae is have to assign for counting vote
        voter.voter_name = _name;
        voter.voter_image = _image;
        voter.voter_address = _address;
        voter.voter_voterId = idNumber;
        voter.voter_vote = 1000; //this is how may candidate have in this
        voter.voter_voted = false;
        voter.voter_ipfs = _ipfs;

        voterAddresses.push(_address);

        emit VoterCreated(
            idNumber,
            _name,
            _image,
            _address,
            voter.voter_allowed,
            voter.voter_voted,
            voter.voter_vote,
            _ipfs
        );
    }

    function vote(
        address _candidateAddress,
        uint256 _candidateVoteId
    ) external {
        Voter storage voter = voters[msg.sender]; // compare with voter data for voting

        require(!voter.voter_voted, "you have already voted"); //initally start with false if you have not voted
        require(voter.voter_allowed != 0, "You have no right to vote"); //who call the fn is not yet register or already voted

        voter.voter_voted = true;
        voter.voter_vote = _candidateVoteId; //have to vote to who candidate

        votedVoterAddresses.push(msg.sender); //push the address to votedVoterAddresses array

        candidates[_candidateAddress].voteCount += voter.voter_allowed;
    }

    function getVoterList() public view returns (address[] memory) {
        return voterAddresses;
    }

    function getVoterLength() public view returns (uint256) {
        return voterAddresses.length;
    }

    function getVoterdata(
        address _address
    )
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            address,
            uint256,
            bool,
            string memory
        )
    {
        return (
            voters[_address].voter_voterId,
            voters[_address].voter_name,
            voters[_address].voter_image,
            voters[_address].voter_address,
            voters[_address].voter_allowed,
            voters[_address].voter_voted,
            voters[_address].voter_ipfs
        );
    }

    function getVotedVoterlist() public view returns (address[] memory) {
        return votedVoterAddresses;
    }

    //-------end of voter section------------//
}
