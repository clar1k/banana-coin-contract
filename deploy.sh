source .env
forge script --chain sepolia script/Banana.s.sol:BananaScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv
