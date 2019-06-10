#!/bin/bash

CHANNEL_NAME="mychannel"
CCNAME="mycc"
CCVERSION="1.0"

SCRIPT_PATH=${PWD}
echo script in $SCRIPT_PATH

export GODEBUG=netdns=go
export FABRIC_CFG_PATH=$SCRIPT_PATH/sampleconfig

setGlobals () {
    ORDERADDRESS="orderer.example.com:7050"
    ORDERER_CA="$SCRIPT_PATH/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
    CORE_PEER_TLS_ROOTCERT_FILE=$SCRIPT_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
	CORE_PEER_TLS_KEY_FILE=$SCRIPT_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key
	CORE_PEER_LOCALMSPID=Org1MSP
	CORE_PEER_TLS_CERT_FILE=$SCRIPT_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt
	CORE_PEER_TLS_ENABLED=true
	CORE_PEER_MSPCONFIGPATH=$SCRIPT_PATH/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
	CORE_LOGGING_LEVEL=DEBUG
	CORE_PEER_ADDRESS=peer0.org1.example.com:7051

    export ORDERADDRESS
    export ORDERER_CA
    export CORE_PEER_TLS_ROOTCERT_FILE
    export CORE_PEER_TLS_KEY_FILE
    export CORE_PEER_LOCALMSPID
    export CORE_PEER_TLS_CERT_FILE
    export CORE_PEER_TLS_ENABLED
    export CORE_PEER_MSPCONFIGPATH
    export CORE_LOGGING_LEVEL
    export CORE_PEER_ADDRESS
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