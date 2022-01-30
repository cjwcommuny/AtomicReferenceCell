import XCTest
@testable import AtomicReferenceCell

final class AtomicReferenceCellTests: XCTestCase {
    struct StructForTest {
        var value: Int
        
        init(_ x: Int = 1) {
            self.value = x
        }
        
        func f() -> StructForTest {
            return StructForTest(2)
        }
        
        mutating func mut_f() {
            self.value = 3
        }
    }
    
    func testArcConformsToCodable() throws {
        XCTAssert(Arc<Int>.self is Codable.Type)
        XCTAssertFalse(Arc<StructForTest>.self is Codable.Type)
    }
    
    func testArcDereferenceFunctionCall() throws {
        let x: Arc<Int> = Arc(1)
        let y = (*x).distance(to: 3)
        assert(y == 2)
    }
    
    func testArcDereferenceInfixOperator() throws {
        let x: Arc<Int> = Arc(1)
        let y: Arc<Int> = Arc(2)
        let z: Int = *x + *y
        assert(z == 3)
    }
    
    func testArcAbstractionCost() throws {
        XCTAssertEqual(MemoryLayout<Arc<Int>>.size, MemoryLayout<Int>.size)
        XCTAssertEqual(MemoryLayout<Arc<StructForTest>>.size, MemoryLayout<StructForTest>.size)
    }
    
    func testWeakArc() throws {
        let x = Arc(1)
        let assertion1 = CFGetRetainCount(x.inner) == 2 // the function also hold the object, so reference count +1
        XCTAssert(assertion1)
        let _ = x.weak()
        let assertion2 = CFGetRetainCount(x.inner) == 2 // the function also hold the object, so reference count +1
        XCTAssert(assertion2)
    }
    
    func testWeakArcDereference() throws {
        let x: Arc<Int> = Arc(1)
        let y: WeakArc<Int> = x.weak()
        let z: Int? = *y
        assert(z == 1)
    }
}
