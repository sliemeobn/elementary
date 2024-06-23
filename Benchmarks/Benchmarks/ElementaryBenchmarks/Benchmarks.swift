import Benchmark
import Elementary

let benchmarks = {
    Benchmark("render a div") { _ in
        blackHole(div {}.render())
    }
}
