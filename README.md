Browser-side code to analyse audio streams.o

Right now, this only works on Chrome and it monitors the microphone. Can be set up to injest arbitrary web audio streams in the future.

If you try and run the included HTML file from a file:// URL on Chrome it will fail silently, because Chrome is awful sometimes. Stand up a local webserver and it'll work.
