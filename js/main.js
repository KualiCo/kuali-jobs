const isCoarse =
  typeof matchMedia !== undefined && matchMedia('(pointer:coarse)').matches

if (!isCoarse) {
  var rellax = new Rellax('.parallax', {
    center: true
  })
}
