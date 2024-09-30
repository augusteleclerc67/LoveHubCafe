//
//  DataManager.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


class DataManager {
    
    static let shared = DataManager()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    private init(){}
    
    func generateCode() -> String {
        var numbers = ""
        for _ in 0..<4 {
            let number = Int.random(in: 0...99)
            numbers += String(format: "%02d", number) + " "
        }
        numbers.removeLast()
        return numbers
    }
    
    func generateTable() -> String {
        return String(Int.random(in: 1...15))
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data("http://loveHubCafe.com/reservation/&ASFA1\(string)".utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    
    var questions = ["What do you like to do in your free time?",
                     "Do you have any hobbies or passions?",
                     "What's your favorite type of music?",
                     "Are you more of an early bird or a night owl?",
                     "Do you enjoy traveling? What's the best place you've visited?",
                     "What's your favorite kind of food?",
                     "Do you prefer the beach or the mountains?",
                     "Do you like reading? If so, what’s the last book you read?",
                     "What’s your favorite movie or TV show?",
                     "Are you more of an introvert or an extrovert?",
                     "Do you have any pets?",
                     "What's something you've always wanted to learn?",
                     "Are you more of a planner or do you like to be spontaneous?",
                     "Do you enjoy sports or any outdoor activities?",
                     "What’s a typical weekend like for you?",
                     "What's your dream job?",
                     "If you could live anywhere in the world, where would it be?",
                     "Do you have a favorite holiday or season?",
                     "What are you most passionate about in life?",
                     "What kind of work do you do?",
                     "Do you prefer coffee or tea?",
                     "What's something on your bucket list?",
                     "Who has been the biggest influence in your life?",
                     "Do you like trying new things or sticking to what you know?",
                     "If you could have dinner with any famous person, living or dead, who would it be?"]
    
    var haveNever = ["I have never been skydiving.",
                     "I have never traveled to another continent.",
                     "I have never eaten sushi.",
                     "I have never gone scuba diving.",
                     "I have never gotten a tattoo.",
                     "I have never ridden a motorcycle.",
                     "I have never been in a hot air balloon.",
                     "I have never gone camping in the wilderness.",
                     "I have never broken a bone.",
                     "I have never gone bungee jumping.",
                     "I have never gotten a speeding ticket.",
                     "I have never sung karaoke in public.",
                     "I have never met a celebrity.",
                     "I have never stayed up for more than 24 hours.",
                     "I have never learned to play a musical instrument.",
                     "I have never been on a blind date.",
                     "I have never gone surfing.",
                     "I have never watched a full season of a reality TV show.",
                     "I have never run a marathon.",
                     "I have never been on a cruise.",
                     "I have never been to a concert.",
                     "I have never dyed my hair a crazy color.",
                     "I have never baked a cake from scratch.",
                     "I have never been on a road trip longer than 8 hours.",
                     "I have never fainted."]
    
    var haveNeverRules = """
"I Have Never" is a fun and simple party game where players get to know each other better by sharing things they’ve never done. Here's how to play:

Starting the Game: One player starts by making a statement that begins with "I have never..." and mentions something they’ve never done (e.g., "I have never gone skydiving.").

Taking Turns: After the first player makes their statement, everyone else who has done that activity must take a drink (if it's a drinking game) or put down a finger (if you're playing with fingers as points). Players who have not done the activity do nothing.

Continuing: The next person in the group takes their turn, also starting with "I have never..." and coming up with a new statement. The game continues clockwise, or in any chosen order.

Winning (Optional): If you're playing with fingers, each player starts with a certain number of fingers up (usually 10), and every time they’ve done something mentioned, they put a finger down. The first person to lose all their fingers is out, and the last person remaining wins.

Variations: The game can also be non-competitive, where players simply take turns sharing and reacting to different experiences without the need for scoring.

Tips:

Keep the statements light and fun to avoid making anyone uncomfortable.
Use this game as an icebreaker to learn fun or surprising facts about your friends!
"""
    
    var truthRules = """
Truth or Dare is a party game where players choose between answering a question truthfully or completing a dare.

How to Play:
Taking Turns: One player asks another, "Truth or dare?"
Choose:
Truth: The player must answer a personal question honestly.
Dare: The player must complete a challenge or task.
Pass the Turn: After completing the truth or dare, the next player asks someone else.
Optional: If a player refuses, they might face a consequence, like doing both a truth and a dare.
Keep it fun and respectful!
"""
    
    var factRules = """
Fun Fact is a great game for couples to get to know each other better while having fun. The game revolves around sharing interesting facts—some true, some false—and trying to figure out which is which.

How to Play:

1. Setting Up: The game is played between two people. One person starts by sharing a fun or unusual fact about themselves. This fact can either be true or false.

2. Sharing the Fact**: The first player describes the fact in detail. It could be anything from a childhood story, an unusual hobby, or a surprising experience. The more details, the better!
   Example: "I once met a famous actor on a trip to Italy, and we ended up having dinner together."

3. Guessing: After hearing the fact, the second player has the chance to figure out if it's **true** or **false**. To help with the decision, they can ask up to 5 questions for clarification or additional information. The first player must answer these questions truthfully if the fact is true, or stay consistent if it’s a lie.

4. Making the Guess: After asking their 5 questions (or fewer), the second player makes their guess: "Truth" or "Lie." The first player then reveals if the fact was true or false.

5. Switching Roles: After the truth is revealed, the players switch roles. Now, the second player shares their own fact, and the first player tries to guess.

Winning (Optional): If you want to keep score, each correct guess is worth 1 point. The game continues for as many rounds as you like, and the person with the most points at the end wins.

Tips:
- Be creative with the facts you share!
- Make the lies believable by mixing in truthful-sounding details.
- Keep the game light-hearted and fun—this is a chance to learn interesting or unexpected things about each other!
"""
    
    var whoAmIRules = """
Who Am I is a fun guessing game for two or more players where each person tries to figure out the identity of a famous person or character assigned to them.

How to Play:
Prepare the Papers: Each player writes the name of a famous person, celebrity, or fictional character on a piece of paper. The name should be well-known to both players.
Swap and Stick: Once both players have written down their names, they exchange papers without looking at them. Each player then sticks the paper on their forehead (or holds it up so that everyone else can see but they cannot).
Asking Questions: The players take turns asking yes-or-no questions to try and figure out the identity of the person or character written on their forehead. Example questions:
"Am I a real person?"
"Am I a man/woman?"
"Am I from a movie?"
Answering: The other player answers yes or no to each question. After each answer, the player can either ask another question or make a guess about who they are.
Guessing: Players keep asking questions until one of them is ready to guess the name on their forehead. The game continues until both players have successfully guessed their identities.
Optional Rules:
Set a limit on the number of questions (e.g., 10 questions each) to make the game faster.
The first person to correctly guess their identity can be declared the winner, or the game can continue until both have guessed.
Tips:
Choose people or characters that are well-known, but not too easy to guess.
Ask broad questions at first (e.g., "Am I alive?"), then narrow down the possibilities with more specific ones.
"""
    
    var matchRules = """
Find the Match is a fun and interactive game for two people designed to help them discover things they have in common. It’s great for bonding and learning more about each other!

How to Play:
Set a Timer: Set a timer for 5 minutes (or choose a different time limit that works for you).
Take Turns Asking Questions: During the timed round, both players take turns asking each other questions to find things they have in common. The questions can be about any topic, such as hobbies, food preferences, travel experiences, or favorite things.
Examples:
"Do you like to travel?"
"What's your favorite type of music?"
"Do you prefer tea or coffee?"
"Have you ever been to a concert?"
Find a Match: When both players discover something they agree on, that’s considered a match! For example, if both players love Italian food or enjoy hiking, they’ve found a match.
Keep Score (Optional): For a more competitive version, keep track of how many matches you find within the time limit. The goal is to find as many commonalities as possible before the timer runs out.
Repeat: After the timer runs out, you can reset it and play again with new questions, or simply enjoy discussing the matches you found.
Winning (Optional): If you’re playing with multiple rounds, the player who finds the most matches in a set number of rounds can be declared the winner.
Tips:
Start with general questions to open up broader topics, and then ask more specific ones to find deeper connections.
Keep the conversation flowing and have fun discovering new things about each other!
"""
}
