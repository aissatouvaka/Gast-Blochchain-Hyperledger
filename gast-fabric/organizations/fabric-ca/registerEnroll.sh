#!/bin/bash

function createOrg1() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/gast1.gast-network.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/gast1.gast-network.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-gast1 --tls.certfiles "${PWD}/organizations/fabric-ca/gast1/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-gast1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-gast1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-gast1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-gast1.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-gast1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/gast1/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-gast1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/gast1/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-gast1 --id.name gast1admin --id.secret gast1adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/gast1/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-gast1 -M "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/msp" --csr.hosts peer0.gast1.gast-network.com --tls.certfiles "${PWD}/organizations/fabric-ca/gast1/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-gast1 -M "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls" --enrollment.profile tls --csr.hosts peer0.gast1.gast-network.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/gast1/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/tlsca/tlsca.gast1.gast-network.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/ca"
  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/peers/peer0.gast1.gast-network.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/ca/ca.gast1.gast-network.com-cert.pem"

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-gast1 -M "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/users/User1@gast1.gast-network.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/gast1/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/users/User1@gast1.gast-network.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://gast1admin:gast1adminpw@localhost:7054 --caname ca-gast1 -M "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/users/Admin@gast1.gast-network.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/gast1/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/gast1.gast-network.com/users/Admin@gast1.gast-network.com/msp/config.yaml"
}

function creategast2.gast-network.com() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/gast2.gast-network.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/gast2.gast-network.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-gast2 --tls.certfiles "${PWD}/organizations/fabric-ca/gast2/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-gast2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-gast2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-gast2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-gast2.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-gast2 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/gast2/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-gast2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/gast2/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-gast2 --id.name gast2admin --id.secret gast2adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/gast2/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-gast2 -M "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/msp" --csr.hosts peer0.gast2.gast-network.com --tls.certfiles "${PWD}/organizations/fabric-ca/gast2/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-gast2 -M "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls" --enrollment.profile tls --csr.hosts peer0.gast2.gast-network.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/gast2/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/tlsca/tlsca.gast2.gast-network.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/ca"
  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/peers/peer0.gast2.gast-network.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/ca/ca.gast2.gast-network.com-cert.pem"

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-gast2.gast-network.com -M "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/users/User1@gast2.gast-network.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/gast2.gast-network.com/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/users/User1@gast2.gast-network.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://gast2.gast-network.comadmin:gast2.gast-network.comadminpw@localhost:8054 --caname ca-gast2.gast-network.com -M "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/users/Admin@gast2.gast-network.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/gast2.gast-network.com/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/gast2.gast-network.com/users/Admin@gast2.gast-network.com/msp/config.yaml"
}

function createOrderer() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/gast-network.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/gast-network.com

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles "${PWD}/organizations/fabric-ca/ordererGast/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/ordererOrganizations/gast-network.com/msp/config.yaml"

  infoln "Registering orderer"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles "${PWD}/organizations/fabric-ca/ordererGast/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the orderer admin"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/ordererGast/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the orderer msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/msp" --csr.hosts orderer.gast-network.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererGast/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/gast-network.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/msp/config.yaml"

  infoln "Generating the orderer-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls" --enrollment.profile tls --csr.hosts orderer.gast-network.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererGast/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls/ca.crt"
  cp "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls/signcerts/"* "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls/server.crt"
  cp "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls/keystore/"* "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls/server.key"

  mkdir -p "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/msp/tlscacerts/tlsca.gast-network.com-cert.pem"

  mkdir -p "${PWD}/organizations/ordererOrganizations/gast-network.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/gast-network.com/orderers/orderer.gast-network.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/gast-network.com/msp/tlscacerts/tlsca.gast-network.com-cert.pem"

  infoln "Generating the admin msp"
  set -x
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/gast-network.com/users/Admin@gast-network.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/gast-network.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/gast-network.com/users/Admin@gast-network.com/msp/config.yaml"
}
