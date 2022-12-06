//
//  LandscapeModel.swift
//  SkeletonHero
//
//  Created by Ikhwan on 05/12/22.
//

import Foundation

struct LandscapeModel {
    let id = UUID()
    let title: String
    let place: String
    let image: String
    let description: String
}

final class LandscapeProvider {
    // Data Source : https://www.gocollette.com/en/traveling-well/2018/2/most-remarkable-landscapes-us
    static func all() -> [LandscapeModel] {
        return [
        LandscapeModel(title: "The Grand Canyon", place: "Arizona", image: "grand-canyon", description: "Photos, videos and documentaries cannot possibly prepare you for what it’s like to actually experience the Grand Canyon. Its vastness takes your breath away, but what will really strike you and stay with you forever, is the stillness. You just have to experience it to believe it."),
        LandscapeModel(title: "The Las Vegas Strip", place: "Nevada", image: "vegas", description: "The seductive nature of this dazzling oasis in the desert is unparalleled. From the Strip’s shimmering excitement to the entertainment, cuisine, luxury hotels and people-watching to the spectacular scenery surrounding Las Vegas itself. It’s a feast for the eyes at every single turn."),
        LandscapeModel(title: "Mount Rushmore", place: "South Dakota", image: "rushmore", description: "Roughly three million visitors a year can’t be wrong! Mt. Rushmore is the most popular attraction in South Dakota. It displays the faces of presidents George Washington, Thomas Jefferson, Abraham Lincoln and Theodore Roosevelt carved into the granite. It’s one of the most iconic sights in all of America and a must-see for locals and foreigners alike."),
        LandscapeModel(title: "Hawaii Volcanoes National Park", place: "Hawaii", image: "hawaii", description: "Massive lava deserts, steaming craters, lava tubes and rainforests await travelers in this spectacular national park. Even with all of Hawaii’s many virtues, this park remains an absolute must see for any traveler to this wonderful and exotic state."),
        LandscapeModel(title: "Denali", place: "Alaska", image: "alaska", description: "Legendary Denali (formerly Mt. McKinley) is one of the world’s greatest and most scenic mountains. It’s absolutely massive, and on a clear day, you can see all 18,000 feet of its height. Prepare to be astounded."),
        LandscapeModel(title: "Yosemite", place: "California", image: "yosemite", description: "Waterfalls, lush green valleys and giant sequoias decorate the country’s third-oldest national park. Visitors to this wonderland of mother nature’s splendor leave enchanted and eternally devoted to their new favorite place on earth. Their cameras, on the other hand, are exhausted and happy to go home and rest."),
        LandscapeModel(title: "Glacier National Park", place: "Montana", image: "montana", description: "Right up there in the ranks with such head-turners as Yosemite, Yellowstone and the Grand Canyon, Glacier National Park is a perfect example of America’s stupendous natural treasures. It’s a wild and sparkling landscape of snowy mountain tops, magnificent waterfalls and stunning turquoise lakes where wildlife roams free."),
        LandscapeModel(title: "Central Park", place: "New York City", image: "central-park", description: "The “people’s park” is one of New York City’s great attractions. It provides New Yorkers with a much-needed outdoor oasis where they can enjoy a simple picnic or one of the many attractions the park has to offer. It’s just as vast and majestic as any other natural space in the country, it just happens to be in the middle of Manhattan."),
        LandscapeModel(title: "Niagara Falls", place: "New York", image: "niagara", description: "150,000 gallons of water plunges more than 1,000 feet down every second. It’s an impressive sight to say the least and it attracts families, honeymooners and curious spectators from around the world who come to be amazed by natural beauty and soaked with water at the same time."),
        LandscapeModel(title: "Redwoods", place: "California", image: "redwoods", description: "Prepare to be blown away by this wild and scenic place where the trees can reach up to 300 feet tall. The sun rarely hits the ground in this part of the world and it’s easy to see why with all of these towering giants overhead. It’s delightfully otherworldly and something you’ll have to see to truly appreciate."),
        LandscapeModel(title: "The Mutianyu Great Wall", place: "China", image: "great-wall", description: "The first thing your friends will ask when you get back is, “Did you walk on the Great Wall?” Considering the immense length and variety of the wall sections, the Mutianyu section, located 65km to the north of Beijing, is a good place to make sure you have a satisfying visit.\nDespite being a popular site, it tends to be a bit less crowded than some of the others. It includes the longest fully-renovated section which is open to tourists, making it safer for you to enjoy your visit. In addition, if you choose to use them, there is a cableway to ride up and down, and a luge to ride down on.\nThis section boasts some especially interesting watchtowers. The view from the wall has magnificent scenery all year round, including the wooded hillsides, pretty Spring flowers, waving Summer grasses, colorful Autumn leaves, and blanketing Winter snow. The most comfortable weather for visiting is in Spring (April – May) and Autumn (September – October). However, crowded times to avoid are May Day holiday (May 1 – 3) and National Day Holiday (October 1 – 7)."),
        LandscapeModel(title: "Tianzi Mountain", place: "China", image: "tianzi", description: "Tianzi Mountain with its stunning scenery lies in the northern part of Wulingyuan Scenic Area in Hunan Province. Here visitors can enjoy views of the weathered sandstone towers which inspired the floating Hallelujah mountains in the movie Avatar. The views of the awe-inspiring peaks rising one beyond another are appreciated in all seasons and times, especially the Sea of Clouds, Rays of Sunshine, and Snow of Winter.\nA six-minute ride in a cable car is an opportunity to take in the wonder of the view and marvel at each remarkable sandstone shape.\nIt’s best to visit between April and October. In April (Spring) you can take the best photographs. Summer has hot days and cool nights, and the air is clear. In Autumn, you can avoid heat and cold and rain. Winter is cold and windy, with heavy snow falls in mid-January to late February creating beautiful snow scenery. As always, avoid the holidays 1-7 May, and 1-7 October."),
        LandscapeModel(title: "Potala Palace", place: "Tibet", image: "potala", description: "The Potala Palace is considered to be a model of Tibetan architecture. Located on the Red Hill in Lhasa, it covers more than 360,000 square meters and has 13 stories. It was first constructed in 641 by Tibetan King Songtsen Gampo in order to welcome his bride, Princess Wencheng of the Tang Dynasty. This structure was later burned to the ground during a war and rebuilt in the 17th century by the Fifth Dalai Lama. Over the past three centuries, the palace has gradually become a place where the Dalai Lama lives and works and a place for preserving the remains of previous Dalai Lamas.")
        ]
    }
}
