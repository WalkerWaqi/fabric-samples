#!/bin/bash

CHANNEL_NAME="mychannel"
CCNAME="mycc"
CCVERSION="1.0"

SCRIPT_PATH=${PWD}
echo script in $SCRIPT_PATH

export GODEBUG=netdns=go
export FABRIC_CFG_PATH=$SCRIPT_PATH/sampleconfig

setGlobals () {
    export ORDERADDRESS=orderer.example.com:7050
    export ORDERER_CA=$SCRIPT_PATH/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
    export CORE_PEER_ID=peer-test
    export CORE_PEER_TLS_ROOTCERT_FILE=$SCRIPT_PATH/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
	export CORE_PEER_TLS_KEY_FILE=$SCRIPT_PATH/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.key
	export CORE_PEER_LOCALMSPID=Org2MSP
	export CORE_PEER_TLS_CERT_FILE=$SCRIPT_PATH/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.crt
	export CORE_PEER_TLS_ENABLED=true
	export CORE_PEER_MSPCONFIGPATH=$SCRIPT_PATH/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
	export CORE_LOGGING_LEVEL=DEBUG
	export CORE_PEER_ADDRESS=peer1.org2.example.com:5051
    export CORE_PEER_LISTENADDRESS=0.0.0.0:5051
    export CORE_PEER_GOSSIP_ENDPOINT=0.0.0.0:5051
    export CORE_PEER_EVENTS_ADDRESS=0.0.0.0:5053
    # export CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:5052

    env | grep CORE
}

CreateFabricNet (){
    PEER=peer

    setGlobals

    $PEER $*

    # $PEER channel join -b $CHANNEL_NAME.block
    # $PEER chaincode install $CCPACKAGE
}

CreateFabricNet $*