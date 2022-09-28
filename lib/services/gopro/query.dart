import '../../logger.dart';
import 'constants.dart';
import 'packet.dart';

class QueryRequest implements RequestPacket {
  List<Setting> requestSettings = [];

  QueryRequest();
  QueryRequest.fromList(List<Setting> settings) : requestSettings = settings;

  void addSetting(Setting setting) {
    requestSettings.add(setting);
  }

  @override
  List<int> toQuery() {
    var query = [3, 18];
    for (var setting in requestSettings) {
      query.add(Constants.SettingsMapReverse[setting]!);
    }
    return query;
  }
}

class QueryResponse {
  int? size;
  int? queryId;
  bool? success;

  Map<Setting, dynamic> values = {};

  void parse(List<int> data) {
    var chunks = _getChunks(data);
    size = chunks[0][0];
    queryId = chunks[0][1];
    success = chunks[0][2] == 0;

    for (var i = 1; i < chunks.length; i++) {
      var chunk = chunks[i];
      var target = Constants.SettingsMap[chunk[0]];
      var key = target['type'];
      var value = target['values'][chunk[2]];
      values[key] = value;
    }
    Logger.log(values.toString(), Logger.cyan);
  }

  List<List<int>> _getChunks(List<int> data) {
    List<List<int>> chunks = [];
    for (var i = 0; i < data.length; i += 3) {
      chunks.add(data.sublist(i, i + 3 > data.length ? data.length : i + 3));
    }
    return chunks;
  }
}

class QueryRequestPackage {}
