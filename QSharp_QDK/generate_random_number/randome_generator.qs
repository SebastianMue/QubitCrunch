namespace RandomeGenerator
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation getRandome(lower: Int, upper:Int) : Int {
        let n = Ceiling(Lg(IntAsDouble(upper)));
        mutable currentNr = new Bool[n];
        repeat {
            for (i in 1 .. n-1) {
                using(q = Qubit())  {
                    H(q);
                    let r = M(q);
                    Reset(q);
                    set currentNr w/= i <- ResultAsBool(r);
                }
            }
        }
        until (BoolArrayAsInt(currentNr) <= upper and BoolArrayAsInt(currentNr) >= lower)
        fixup {
            set currentNr = new Bool[n];
        }
        return BoolArrayAsInt(currentNr);
    }
}
