

# 각 피어 체인코드 실행
## 시리얼 관리 채널 체인코드
## 한번에 하나씩
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode install -n car_001_Serial -v 0.1 -l node -p /var/hyperledger/chaincode/node
docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer chaincode install -n car_001_Serial -v 0.1 -l node -p /var/hyperledger/chaincode/node
docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer chaincode install -n car_001_Serial -v 0.1 -l node -p /var/hyperledger/chaincode/node

# ## 이력 관리 채널 체인코드
# docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode install -n car_002_Management -v 0.1 -l node -p /var/hyperledger/chaincode/node
# docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer chaincode install -n car_002_Management -v 0.1 -l node -p /var/hyperledger/chaincode/node
# docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer chaincode install -n car_002_Management -v 0.1 -l node -p /var/hyperledger/chaincode/node



# nodejs chaincode instantiate
# 체인코드 도커 컨테이너를 생성 및 구동
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode instantiate -o orderer001:7050 -C carchannel001 -n car_001_Serial -v 0.1 -c '{"Args":["init"]}' -P "OR('carAssociationOrgMSP.member','carInsuranceOrgMSP.member','carMaintenanceOrgMSP.member')"
# docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode instantiate -o orderer001:7050 -C carchannel002 -n car_002_Management -v 0.1 -c '{"Args":["init"]}' -P "OR('carAssociationOrgMSP.member','carInsuranceOrgMSP.member','carMaintenanceOrgMSP.member')"
