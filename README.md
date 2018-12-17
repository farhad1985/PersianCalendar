# PersianCalendar
 PersianCalendar written in Swift
 
<p align="center">
 <img src="https://github.com/farhad1985/PersianCalendar/blob/master/Screenshot/persianICON.png" align="center" width="200" max-width="50%"  />
</p>

## Screenshot

<img src="https://github.com/farhad1985/PersianCalendar/blob/master/Screenshot/screenshot1.png" />

now you can use of PersianCalendar in your project

## How to install

open your terminal and enter pod install

```
pod 'PersianCalendar'
```

## In Storyboard

you can use persiancalendar in your storyboard. you should add a view to your viewcontroller and inherit of PersianCalendar

<img src="https://github.com/farhad1985/PersianCalendar/blob/master/Screenshot/Screen%20Shot%202018-12-17%20at%208.45.32%20AM.png" width="350" max-width="50%" />

## In Code

PersianCaldendar has a Delegate for take your selection Date.

```swift
@IBOutlet weak var vwCalendar: PersianCalendarView!
    
override func viewDidLoad() {
  super.viewDidLoad()
        
  vwCalendar.delegate = { calDate in
      print(calDate)
  }
}
```

and if you want to change font :

```swift
vwCalendar.font = UIFont(name: "IRANSansMonoSpacedNum-Light", size: 20)!
```
