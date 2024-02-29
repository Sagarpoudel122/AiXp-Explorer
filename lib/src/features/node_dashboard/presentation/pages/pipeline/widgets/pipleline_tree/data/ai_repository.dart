part of ai;

class AIRepository {
  factory AIRepository() => _singleton;

  AIRepository._internal() : super();
  static final AIRepository _singleton = AIRepository._internal();

  Future<bool> createPipelineForBox({
    required String boxName,
    required String pipelineName,
    required String dctType,
    required JsonMap config,
  }) async {
    try {
      final HttpResponse<JsonMap> response = await HttpClient.instance.postTyped<JsonMap, JsonMap>(
        path: '/ai/$boxName/pipelines',
        body: <String, dynamic>{
          'name': pipelineName,
          'type': dctType,
          'config': config,
        },
      );
      return response.rawResponse.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<List<AIPluginType>> getPluginTypes() async {
    final HttpResponse<List<AIPluginType>> response = await HttpClient.instance.getTyped<List<AIPluginType>>(
      path: 'ai/plugins',
      responseFromJson: (dynamic json) => (json as List<dynamic>)
          .map(
            (dynamic e) => AIPluginType.fromMap(e as Map<String, dynamic>),
          )
          .toList(),
    );
    return response.body;
  }

  Future<List<String>> getLastWitness({
    required String node,
    required String pipeline,
    required String instance,
  }) async {
    final HttpResponse<List<String>> response = await HttpClient.instance.getTyped<List<String>>(
      path: 'ai/$node/pipelines/$pipeline/instances/$instance/last-witness',
      responseFromJson: (dynamic json) => ((json as Map<String, dynamic>)['images'] as List<dynamic>)
          .map(
            (dynamic e) => e as String,
          )
          .toList(),
    );
    return response.body;
  }

  Future<List<AIPipelineDTO>> getPipelinesForBox({
    required String boxName,
  }) async {
    try {
      final HttpResponse<List<AIPipelineDTO>> response = await HttpClient.instance.getTyped<List<AIPipelineDTO>>(
        path: 'ai/$boxName/pipelines',
        responseFromJson: (dynamic json) => (json as List<dynamic>)
            .map(
              (dynamic e) => AIPipelineDTO.fromMap(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response.body;
    } catch (e) {
      // Toast(
      //   type: ToastType.error,
      //   title: 'Could not get pipelines for box $boxName',
      // ).show();
    }
    return <AIPipelineDTO>[];
  }

  Future<List<AIPluginInstanceReference>> getPluginInstances({
    required String boxName,
    required String pipelineName,
  }) async {
    final HttpResponse<List<AIPluginInstanceReference>> response =
        await HttpClient.instance.getTyped<List<AIPluginInstanceReference>>(
      path: 'ai/$boxName/pipelines/$pipelineName/instances',
      responseFromJson: (dynamic json) => (json as List<dynamic>)
          .map(
            (dynamic e) => AIPluginInstanceReference.fromMap(e as Map<String, dynamic>),
          )
          .toList(),
    );
    return response.body;
  }

  Future<AIPluginInstanceDTO> getPluginInstance({
    required String boxName,
    required String pipelineName,
    required String pluginInstanceName,
  }) async {
    final HttpResponse<AIPluginInstanceDTO> response = await HttpClient.instance.getTyped<AIPluginInstanceDTO>(
      path: 'ai/$boxName/pipelines/$pipelineName/instances/$pluginInstanceName',
      responseFromJson: (dynamic json) => AIPluginInstanceDTO.fromMap(json as Map<String, dynamic>),
    );
    return response.body;
  }

  Future<AIDCTSnapshot?> getPipelineSnapshot({
    required String boxName,
    required String pipelineName,
  }) async {
    /*final Map<String, dynamic> snapshotMockJson = jsonDecode(snapshotMock2) as Map<String, dynamic>;
    return AIDCTSnapshot.fromMap(snapshotMockJson);*/

    try {
      final HttpResponse<AIDCTSnapshot> response = await HttpClient.instance.getTyped<AIDCTSnapshot>(
        path: '/ai/$boxName/pipelines/$pipelineName/snapshot',
        responseFromJson: (dynamic json) => AIDCTSnapshot.fromMap(json as Map<String, dynamic>),
      );
      return response.body;
    } catch (error) {
      // Toast(
      //   type: ToastType.error,
      //   title: AppStrings.snapshotNotFound.translated,
      // ).show();
      return null;
    }
  }

  Future<AIDCT> getDCTForType({
    required String dctType,
  }) async {
    final HttpResponse<AIDCT> response = await HttpClient.instance.getTyped<AIDCT>(
      path: '/ai/dct/$dctType',
      responseFromJson: (dynamic json) => AIDCT.fromMap(json as Map<String, dynamic>),
      callOnError: false,
    );

    return response.body;
  }

  Future<AIPluginSchemaDTO> getPluginSchemaForSignature({
    required String signature,
  }) async {
    final HttpResponse<AIPluginSchemaDTO> response = await HttpClient.instance.getTyped<AIPluginSchemaDTO>(
      path: '/ai/plugins/$signature',
      responseFromJson: (dynamic json) => AIPluginSchemaDTO.fromMap(json as Map<String, dynamic>),
      callOnError: false,
    );

    return response.body;
  }

  Future<List<AIDCTListItem>> getDCTTypes() async {
    final HttpResponse<List<AIDCTListItem>> response = await HttpClient.instance.getTyped<List<AIDCTListItem>>(
      path: 'ai/dct',
      responseFromJson: (dynamic json) => (json as List<dynamic>)
          .map(
            (dynamic e) => AIDCTListItem.fromMap(e as Map<String, dynamic>),
          )
          .toList(),
    );
    return response.body;
  }

  Future<List<PluginActionDTO>> getPluginActions() async {
    final HttpResponse<List<PluginActionDTO>> response = await HttpClient.instance.getTyped<List<PluginActionDTO>>(
      path: 'ai/plugins/plugin-actions',
      responseFromJson: (dynamic json) => (json as List<dynamic>)
          .map(
            (dynamic e) => PluginActionDTO.fromMap(e as Map<String, dynamic>),
          )
          .toList(),
    );
    return response.body;
  }

  Future<bool> deletePipeline({
    required String boxName,
    required String pipelineName,
    bool? force,
  }) async {
    // final http.Response response = await HttpClient.instance.deleteForPath(
    //   path: '/ai/$boxName/pipelines/$pipelineName',
    // );

    final http.Response response = await HttpClient.instance.deleteTypedInput<JsonMap>(
      path: '/ai/$boxName/pipelines/$pipelineName',
      body: <String, dynamic>{
        'force': force,
      }..removeWhere(
          (String key, dynamic value) => value == null,
        ),
    );

    final bool isSuccessful = (response.statusCode == 200);

    if (!isSuccessful) {
      // Toast(
      //   type: ToastType.error,
      //   title: 'Could not delete pipeline $pipelineName - result: ${response.statusCode}',
      // ).show();
    }

    return isSuccessful;
  }

  Future<bool> addPluginInstance({
    required String boxName,
    required String pipelineName,
    required AIPluginInstanceDTO instanceDTO,
    String? clientUuid,
  }) async {
    try {
      final http.Response response = await HttpClient.instance.postTypedInput<JsonMap>(
        path: '/ai/$boxName/pipelines/$pipelineName/instances',
        body: <String, dynamic>{
          ...instanceDTO.toMap(),
          if(clientUuid != null) 'client' : clientUuid,
        },
      );

      final bool isSuccesful = (response.statusCode == 201);
      if (!isSuccesful) {
        // Toast(
        //   type: ToastType.error,
        //   title: 'Could not create pluginInstance ${instanceDTO.name} - result: ${response.statusCode}',
        // ).show();
      }

      debugPrint('addPluginInstance - result: ${response.body}');

      return isSuccesful;
    } catch (e) {
      if (e is HttpErrorResponse) {
        // Toast(
        //   type: ToastType.error,
        //   title: e.message,
        // ).show();
      }
    }
    return false;
  }

  Future<bool> updatePluginInstance({
    required String boxName,
    required String pipelineName,
    required AIPluginInstanceDTO instanceDTO,
  }) async {
    try {
      final http.Response response = await HttpClient.instance.patchTypedInput<JsonMap>(
        path: '/ai/$boxName/pipelines/$pipelineName/instances/${instanceDTO.name}',
        body: instanceDTO.toMap(),
      );

      final bool isSuccesful = (response.statusCode == 200);
      if (!isSuccesful) {
        // Toast(
        //   type: ToastType.error,
        //   title: 'Could not update pluginInstance ${instanceDTO.name} - result: ${response.statusCode}',
        // ).show();
      }

      debugPrint('updatePluginInstance - result: ${response.body}');

      return isSuccesful;
    } catch (e) {
      if (e is HttpErrorResponse) {
        // Toast(
        //   type: ToastType.error,
        //   title: e.message,
        // ).show();
      }
    }
    return false;
  }

  Future<bool> deletePluginInstance({
    required String boxName,
    required String pipelineName,
    required String instanceID,
  }) async {
    final http.Response response = await HttpClient.instance.deleteForPath(
      path: '/ai/$boxName/pipelines/$pipelineName/instances/$instanceID',
    );
    final bool isSuccesful = (response.statusCode == 200);

    if (!isSuccesful) {
      // Toast(
      //   type: ToastType.error,
      //   title: 'Could not delete pipeline $pipelineName - result: ${response.statusCode}',
      // ).show();
    }

    return isSuccesful;
  }

  Future<(int, bool)> getAffectedInstancesCountByHostPipeline({
    required String host,
    required String pipeline,
  }) async {
    final HttpResponse<List<JsonMap>> response = await HttpClient.instance.postTyped<JsonMap, List<JsonMap>>(
      path: '/ai/plugins/affected-instances',
      body: <String, dynamic>{
        'host': host,
        'pipeline': pipeline,
      },
      responseFromJson: (dynamic json) => (json as List<dynamic>).map((dynamic e) => e as JsonMap).toList(),
    );

    final bool isSuccess = (response.rawResponse.statusCode == 201);
    if (!isSuccess) {
      // Toast(
      //   type: ToastType.error,
      //   title: 'Could not get affected instances for $host - $pipeline - result: ${response.rawResponse.statusCode}',
      // ).show();
      return (0, isSuccess);
    }

    return (response.body.length, isSuccess);
  }
}
