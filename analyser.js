(function() {
  var getAverageVolume;

  getAverageVolume = function(array) {
    var average, total, value, _i, _len;
    total = 0;
    for (_i = 0, _len = array.length; _i < _len; _i++) {
      value = array[_i];
      total += value;
    }
    average = total / length;
    return average;
  };

  window.Analyser = function(opts, cb) {
    var analyser, audioCtx, failure, success;
    if (typeof opts === 'function') {
      cb = opts;
      opts = {};
    }
    audioCtx = new (window.AudioContext || window.webkitAudioContext)();
    analyser = audioCtx.createAnalyser();
    window.success = success = function(stream) {
      var source;
      analyser.fftsize = opts.fftsize || 5;
      analyser.smoothingTimeConstant = opts.smoothingTimeConstant || 0;
      source = audioCtx.createMediaStreamSource(stream);
      source.connect(analyser);
      return cb(null, {
        getVolume: function() {
          var dataArray;
          dataArray = new Uint8Array(analyser.frequencyBinCount);
          analyser.getByteFrequencyData(dataArray);
          return getAverageVolume(dataArray);
        }
      });
    };
    window.failure = failure = function(err) {
      return cb(err);
    };
    return navigator.webkitGetUserMedia({
      audio: true
    }, success, failure);
  };

}).call(this);
