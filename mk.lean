partial def num2letters (n : Nat) : String :=
  if n >= 26 then
    num2letters (n / 26 - 1) ++ num2letters (n % 26)
  else
    Char.toString <| .ofNat <| 'A'.toNat + n

def main (args : List String) : IO Unit := do
  let [some layers, some width] := args.map String.toNat? | do
    IO.println "Usage: lean --run mk.lean layers width"
    IO.Process.exit 1

  let mkImportsFor (layer : Nat) := Id.run do
    let mut out := ""
    for idx in [:width] do
      out := out ++ s!"import Inundation.{num2letters layer}{idx}\n"
    return out
  let mkImportsAt (layer : Nat) :=
    if let prev + 1 := layer then mkImportsFor prev else ""

  IO.FS.removeDirAll "Inundation"
  IO.FS.createDir "Inundation"
  for layer in [:layers] do
    for idx in [:width] do
      IO.FS.writeFile ("Inundation" / s!"{num2letters layer}{idx}.lean") <|
        mkImportsAt layer

  IO.FS.writeFile "Inundation.lean" (mkImportsAt layers)
