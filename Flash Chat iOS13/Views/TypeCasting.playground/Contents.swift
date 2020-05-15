import Foundation

class animal{
    var name: String
    
    init(n: String) {
        name = n
    }
}

class human: animal{
    func code(){
        print("Typing on and on....")
    }
}

class fish: animal{
    func breath(){
        print("Breathing under water..")
    }
}

let sagar = human(n: "sagar")
let fizan = human(n: "fizan")
let memo = fish(n: "memo")
let number = 12
struct comodoDragon{
    let name = "ComodoDragon"
}
let num: NSNumber = 12
let word: NSString = "Pokemon"

let friends = [sagar,fizan,memo]
let friends1: [Any] = [sagar,fizan,memo,comodoDragon.self,number]  //here we can store any type of datatypes
let friends2: [AnyObject] = [sagar,fizan,memo]  //this accepts only objects and not structures where comodoDragon and number which is int is a struct and not objects
let friends3: [NSObject] = [num,word]  //this accepts only NSObjects which are made by apple

if friends[0] is human{
    print("First friend is a human")
}
else{
    print("First friend is a fish")
}


//Using 'is' to implement typechecking
func findFish(from animals: [animal]){
    for animal in animals{
        if animal is fish{  //checking if animal is of type fish
            print(animal.name)
            let fish = animal as! fish  //now pulling the animal forcefully to type fish and this is called 'forced downcast'
            fish.breath()
            let animalFish = fish as animal     //This is called upcasting
        }
        else{
            continue
        }
    }
}
findFish(from: friends)

/*
 as!
 let messageCell = cell as! MessageCell
 */

//we dont get any warning but after running it we will see the error

//let fish = friends[0] as! fish    //#this gives error in the output window

//so we use as?
//as?
let fish1 = friends[0] as? fish

if let fish2 = friends[2] as? fish{
    fish2.breath()
}

/*
 using 'as?' in place of 'is' is more safe
 */
