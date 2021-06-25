#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

function creategast3 {
	infoln "Enrolling the CA admin"
	mkdir -p ../organizations/peerOrganizations/gast3.gast-network.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-gast3 --tls.certfiles "${PWD}/fabric-ca/gast3/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-gast3.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-gast3.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-gast3.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-gast3.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/msp/config.yaml"

	infoln "Registering peer0"
  set -x
	fabric-ca-client register --caname ca-gast3 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/fabric-ca/gast3/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-gast3 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/fabric-ca/gast3/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-gast3 --id.name gast3admin --id.secret gast3adminpw --id.type admin --tls.certfiles "${PWD}/fabric-ca/gast3/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-gast3 -M "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/msp" --csr.hosts peer0.gast3.gast-network.com --tls.certfiles "${PWD}/fabric-ca/gast3/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-gast3 -M "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls" --enrollment.profile tls --csr.hosts peer0.gast3.gast-network.com --csr.hosts localhost --tls.certfiles "${PWD}/fabric-ca/gast3/tls-cert.pem"
  { set +x; } 2>/dev/null


  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls/ca.crt"
  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls/signcerts/"* "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls/server.crt"
  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls/keystore/"* "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls/server.key"

  mkdir "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/msp/tlscacerts"
  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/msp/tlscacerts/ca.crt"

  mkdir "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/tlsca"
  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/tlsca/tlsca.gast3.gast-network.com-cert.pem"

  mkdir "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/ca"
  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/peers/peer0.gast3.gast-network.com/msp/cacerts/"* "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/ca/ca.gast3.gast-network.com-cert.pem"

  infoln "Generating the user msp"
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca-gast3 -M "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/users/User1@gast3.gast-network.com/msp" --tls.certfiles "${PWD}/fabric-ca/gast3/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/users/User1@gast3.gast-network.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
	fabric-ca-client enroll -u https://gast3admin:gast3adminpw@localhost:11054 --caname ca-gast3 -M "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/users/Admin@gast3.gast-network.com/msp" --tls.certfiles "${PWD}/fabric-ca/gast3/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/gast3.gast-network.com/users/Admin@gast3.gast-network.com/msp/config.yaml"
}
