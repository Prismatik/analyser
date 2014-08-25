getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia

getAverageVolume = (array) ->
  values = 0
  average = undefined
  length = array.length
  
  # get all the frequency amplitudes
  i = 0

  while i < length
    values += array[i]
    i++
  average = values / length
  return average

module.exports = (opts = {}, cb) ->
  audioCtx = new (window.AudioContext or window.webkitAudioContext)()
  analyser = audioCtx.createAnalyser()
  success = (stream) ->
    analyser.fftsize = opts.fftsize or 5
    analyser.smoothingTimeConstant = opts.smoothingTimeConstant or 0
    source = audioCtx.createMediaStreamSource stream
    source.connect analyser

    return cb null, ->
      dataArray = new Uint8Array(anallyser.frequencyBinCount)
      analyser.getByteFrequencyData(dataArray)
      return getAverageVolume(dataArray)

  failure = (err) ->
    return cb err

  return getUserMedia {
    audio: true
  }, success, failure
