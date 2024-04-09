class NodeHistoryModel {
  NodeHistory nodeHistory;

  NodeHistoryModel({
    required this.nodeHistory,
  });

  factory NodeHistoryModel.fromJson(Map<String, dynamic> json) {
    return NodeHistoryModel(
      nodeHistory: NodeHistory.fromJson(json['NODE_HISTORY']),
    );
  }
}

class NodeHistory {
  List<num> cpuHist;
  List<num> gpuLoadHist;
  List<num> gpuMemAvailHist;
  num gpuMemTotal;
  List<num> memAvailHist;
  List<String> timestamps;
  num totalDisk;
  num totalMem;

  NodeHistory({
    required this.cpuHist,
    required this.gpuLoadHist,
    required this.gpuMemAvailHist,
    required this.gpuMemTotal,
    required this.memAvailHist,
    required this.timestamps,
    required this.totalDisk,
    required this.totalMem,
  });

  factory NodeHistory.fromJson(Map<String, dynamic> json) {
    return NodeHistory(
      cpuHist: List<num>.from(json['cpu_hist']),
      gpuLoadHist: List<num>.from(json['gpu_load_hist']),
      gpuMemAvailHist: List<num>.from(
        json['gpu_mem_avail_hist'],
      ),
      gpuMemTotal: json['gpu_mem_total'],
      memAvailHist: List<num>.from(json['mem_avail_hist']),
      timestamps: List<String>.from(json['timestamps']),
      totalDisk: json['total_disk'],
      totalMem: json['total_mem'],
    );
  }
}



  // "NODE_HISTORY": {
  //   "cpu_hist": [3.9, 3.8, 4.1, 4.2, 4.1, 4.0, 4.1, 4.1, 4.2],
  //   "gpu_load_hist": [0, 0, 0, 0, 0, 0, 0, 0, 0],
  //   "gpu_mem_avail_hist": [
  //     7.78, 7.78, 7.78, 7.78, 7.78, 7.78, 7.78, 7.78, 7.78
  //   ],
  //   "gpu_mem_total": 7.79,
  //   "mem_avail_hist": [
  //     0.9132403957342927, 0.9133367596042657, 0.9129513041243736,
  //     0.9133688808942566, 0.9131761531543106, 0.9123731209045355,
  //     0.9124694847745085, 0.9126622125144546, 0.9124694847745085
  //   ],
  //   "timestamps": [
  //     "2024-04-08 10:38:39",
  //     "2024-04-08 10:41:59",
  //     "2024-04-08 10:45:20",
  //     "2024-04-08 10:48:40",
  //     "2024-04-08 10:52:01",
  //     "2024-04-08 10:55:21",
  //     "2024-04-08 10:58:42",
  //     "2024-04-08 11:02:02",
  //     "2024-04-08 11:05:23"
  //   ],
  //   "total_disk": 937.331,
  //   "total_mem": 31.132
  // },