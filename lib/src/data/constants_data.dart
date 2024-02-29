import '../features/node_dashboard/pages/pipeline/widgets/pipleline_tree/data/dto/business_client.dart';
import '../features/node_dashboard/pages/pipeline/widgets/pipleline_tree/data/dto/equipment_dto.dart';
import '../features/node_dashboard/pages/pipeline/widgets/pipleline_tree/data/dto/location.dart';

final user = [
  {
    "uuid": "2efe191d-665d-44fc-9014-77845c9df67d",
    "name": "Hyperfy",
    "languages": null,
    "active": true
  },
  {
    "uuid": "9dc9a1ea-4732-4723-bab9-c5a15f39d588",
    "name": "BMW",
    "languages": null,
    "active": true
  },
  {
    "uuid": "21eb7c00-e4b0-4f58-8147-f258f5f2f5a6",
    "name": "TEST Tenant",
    "languages": null,
    "active": true
  }
];

List<Location> locationconstantList = const [
  Location(
      uuid: "d6860e41-b836-456f-a8ad-1eb1bd284547",
      name: "Nusco",
      timezone: "Europe/Bucharest",
      client: BusinessClient(uuid: "2efe191d-665d-44fc-9014-77845c9df67d", name: "Hyperfy")),
  Location(
      uuid: "385055a7-d6ef-4342-afc3-c9a6df3dee07",
      name: "Man Otopeni",
      timezone: "Europe/Bucharest",
      client: BusinessClient(uuid: "9dc9a1ea-4732-4723-bab9-c5a15f39d588", name: "BMW")),
  Location(
      uuid: "d56454eb-e3f3-4819-9c4e-353cb018ca98",
      name: "NUSCO 3",
      timezone: "Europe/Bucharest",
      client: BusinessClient(uuid: "2efe191d-665d-44fc-9014-77845c9df67d", name: "Hyperfy")),
  Location(
      uuid: "e0b4ff8-2254-4ee8-8567-fd77c4881f21",
      name: "BT",
      timezone: "Europe/Bucharest",
      client: BusinessClient(uuid: "2efe191d-665d-44fc-9014-77845c9df67d", name: "Hyperfy")),
  Location(
      uuid: "0c2d7211-db54-4ded-acb3-8a17f7fe9422",
      name: "test",
      timezone: "Europe/Bucharest",
      client: BusinessClient(uuid: "21eb7c00-e4b0-4f58-8147-f258f5f2f5a6", name: "TEST Tenant")),
];

final constLocation = [
  {
    "uuid": "83aae474-6fe8-438a-b177-e271a237e934",
    "name": "test",
    "timezone": "Europe/Bucharest",
    "client": {
      "uuid": "2efe191d-665d-44fc-9014-77845c9df67d",
      "name": "Hyperfy",
      "locations": [
        {
          "uuid": "d6860e41-b836-456f-a8ad-1eb1bd284547",
          "name": "Nusco",
          "timezone": "Europe/Bucharest"
        },
        {
          "uuid": "d56454eb-e3f3-4819-9c4e-353cb018ca98",
          "name": "NUSCO 3",
          "timezone": "Europe/Bucharest"
        },
        {
          "uuid": "ce0b4ff8-2254-4ee8-8567-fd77c4881f21",
          "name": "BT",
          "timezone": "Europe/Bucharest"
        },
        {
          "uuid": "663b2c84-bb0b-4fae-9c31-82fa00a87b50",
          "name": "LOAD OZV1",
          "timezone": "Europe/Bucharest"
        },
        {
          "uuid": "83aae474-6fe8-438a-b177-e271a237e934",
          "name": "test",
          "timezone": "Europe/Bucharest"
        }
      ]
    },
    "partitions": []
  },
  {
    "uuid": "0c2d7211-db54-4ded-acb3-8a17f7fe9422",
    "name": "test",
    "timezone": "Europe/Bucharest",
    "client": {
      "uuid": "21eb7c00-e4b0-4f58-8147-f258f5f2f5a6",
      "name": "TEST Tenant",
      "locations": [
        {
          "uuid": "0c2d7211-db54-4ded-acb3-8a17f7fe9422",
          "name": "test",
          "timezone": "Europe/Bucharest"
        }
      ]
    },
    "partitions": []
  }
];

List<EquipmentDTO> equipmentDtoContastant = [
  EquipmentDTO(
      uuid: "kknasdkknda",
      name: "dmsakdnkasd",
      description: "dskadknasdknas",
      type: "EDGEDEVICE",
      metadata: {},
      location: const Location(uuid: "d6860e41-b836-456f-a8ad-1eb1bd284547", name: "name"),
      updatedDate: DateTime.now(),
      client: const BusinessClient(uuid: "uuid", name: "name")),
  EquipmentDTO(
      uuid: "kknasdkknda",
      name: "cm124",
      description: "CM02",
      type: "EDGEDEVICE",
      metadata: {},
      location: Location(uuid: "0c2d7211-db54-4ded-acb3-8a17f7fe9422", name: "name"),
      updatedDate: DateTime.now(),
      client: BusinessClient(uuid: "uuid", name: "name"))
];
