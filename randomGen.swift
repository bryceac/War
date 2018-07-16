import Foundation

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

func RandomGen(number: Int) -> Int {
    #if os(Linux)
        return random() % number
    #else
        return Int(arc4random_uniform(UInt32(number)))
    #endif
}
