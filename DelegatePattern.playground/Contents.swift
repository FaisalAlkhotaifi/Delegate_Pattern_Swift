import UIKit


/**
 Credit goes to: https://learnappmaking.com/delegation-swift-how-to/
 
 The official Apple documentation defines delegation as:
     Delegation is a design pattern that enables a class to hand off (or “delegate”)
     some of its responsibilities to an instance of another class.
 
 Another explaination
 
 Think about delegation in the real world. Imagine you and I are part of a team that
 delivers chocolate cookies to an event. You’re in charge of baking cookies, and you
 delegate making the cookie dough to me. Once I’m done I give the cookie dough to you,
 so you can use it to bake the cookies.

 A few key points stand out:

 - You’re in charge of making cookies, and you delegate creating cookie dough to me
 - You could say that making cookies is your responsibility, and you’re handing off some of that responsibility to me
 - And it goes two ways: I give you the cookie dough once I’m done with my delegated task
 */

struct Cookie {
    var size: Int = 5
    var hasChocolateChip: Bool = false
}

/**
 Selling cookies isn’t the bakery’s responsibility, but producing cookies is.
 So, we need a way to deliver cookies once they are baked without coding all that into the Bakery class.
 That’s where delegation comes in!
 */

protocol BakeryDelegate {
    func cookieWasBaked(_ cookie: Cookie)
    func perferredCookieSize() -> Int?
}

class Bakery {
    var delegate: BakeryDelegate?
    
    func makeCookie() {
        var cookie = Cookie()
        cookie.size = delegate?.perferredCookieSize() ?? 6
        cookie.hasChocolateChip = false
        
        delegate?.cookieWasBaked(cookie)
    }
}

/**
 summarizing:
    you’ve now defined a BakeryDelegate protocol that defines some of the responsibilities that the Bakery delegates,
    and you’ve implemented the hand-off in makeCookie().
 */

// let’s create the actual delegate class

class CookieShop: BakeryDelegate {
    func cookieWasBaked(_ cookie: Cookie) {
        print("Yay! A new cookie was baked, with size \(cookie.size)")
    }
    
    func perferredCookieSize() -> Int? {
        return nil
    }
}


let shop = CookieShop()

let bakery = Bakery()
bakery.delegate = shop

bakery.makeCookie()
