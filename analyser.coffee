
getAverageVolume = (array) ->
  total = 0
  for value in array
    total += value

  average = total / length
  return average

window.Analyser = (opts, cb) ->
  if typeof opts is 'function'
    cb = opts
    opts = {}
  audioCtx = new (window.AudioContext or window.webkitAudioContext)()
  analyser = audioCtx.createAnalyser()
  window.success = success = (stream) ->
    analyser.fftsize = opts.fftsize or 5
    analyser.smoothingTimeConstant = opts.smoothingTimeConstant or 0
    source = audioCtx.createMediaStreamSource stream
    source.connect analyser

    return cb null,
      getVolume: ->
        dataArray = new Uint8Array(analyser.frequencyBinCount)
        analyser.getByteFrequencyData(dataArray)
        return getAverageVolume(dataArray)

  window.failure = failure = (err) ->
    return cb err

  navigator.webkitGetUserMedia { audio: true }, success, failure
