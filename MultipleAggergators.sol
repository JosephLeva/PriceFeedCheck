// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED
 * VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */

/**
 * If you are reading data feeds on L2 networks, you must
 * check the latest answer from the L2 Sequencer Uptime
 * Feed to ensure that the data is accurate in the event
 * of an L2 sequencer outage. See the
 * https://docs.chain.link/data-feeds/l2-sequencer-feeds
 * page for details.
 */

contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */

    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }


    mapping(string=> AggregatorV3Interface) public PriceFeedContracts;
    string[] public aggergators;


    constructor() {
        owner= msg.sender;

    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer(string memory _aggergatorName) public view returns (int) {
        // prettier-ignore

        require(PriceFeedContracts[_aggergatorName]!= AggregatorV3Interface(address(0)),"Aggergator Not Supported");
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = PriceFeedContracts[_aggergatorName].latestRoundData();
        return answer;
    }


    function setPriceFeedAggergator(string memory _aggergatorName, address _contractAddress) external onlyOwner {
        PriceFeedContracts[_aggergatorName]= AggregatorV3Interface(_contractAddress);
        aggergators.push(_aggergatorName);

    }




}
