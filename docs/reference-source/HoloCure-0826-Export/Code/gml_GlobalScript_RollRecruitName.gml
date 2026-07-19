function RollRecruitName()
{
    var names;
    if (global.CurrentLanguage == "eng")
    {
        names = ["John", "Bob", "Mike", "Billy", "Brandon", "Richard", "Sam", "Sarah", "Chloe", "Britany", "Theodore", "Penny", "Ryan", "Joey", "Stan", "Jeremy", "Cody", "Luke", "Lawrence", "Cindy", "Jim", "James", "Ash", "Mary", "Lisa", "Jessica", "Matthew", "Thomas", "Donald", "Anthony", "William", "Ronald", "Jason", "Connor", "Grant", "Larry", "Patrick", "Alex", "Greg", "Olivia", "Victoria", "Heather", "Adam", "Zack", "Ethan", "Peter", "Christina", "Evelyn", "Julia", "Sophia", "Arthur", "Elijah", "Vincent", "Mason", "Aaron", "Henry"];
    }
    else if (global.CurrentLanguage == "jp")
    {
        names = ["Satoshi", "Aoi", "Kiyoshi", "Akira", "Haru", "Hana", "Haruki", "Hiroshi", "Yuki", "Akio", "Goro", "Fuyo", "Dai", "Eido", "Enki", "Ishi", "Akiyama", "Yasuo", "Yutaka", "Miyo", "Miyuki", "Nanami", "Nami", "Nishi", "Rei", "Nana", "Sayako", "Saya", "Toyo", "Tazu", "Taka", "Yuka", "Yasu", "Yuri", "Yukako", "Kei", "Kyoko", "Mai", "Maiko", "Masago", "Matsuko", "Masao", "Ryuichi", "Shiro", "Kuro", "Taro", "Misako", "Chiyo", "Jin"];
    }
    else if (global.CurrentLanguage == "Id")
    {
        names = ["Adit", "Agus", "Agung", "Anggit", "Andra", "Arya", "Bambang", "Budi", "Ahmad", "Dimas", "Fauzan", "Kunto", "Aji", "Rangga", "Damar", "Dewi", "Susanti", "Susi", "Andi", "Jati", "Joko", "Sukro", "Yudi", "Bagas", "Satria", "Ayu", "Nadia", "Bunga", "Anisa", "Sri", "Indah", "Wahyu", "Eko", "Desi", "Putra", "Adi", "Citra", "Surya", "Rizki", "Reza", "Arif", "Hadi", "Dinda", "Indra", "Taufik", "Hanif", "Ilham", "Rahmat", "Duta", "Asep"];
    }
    return names[irandom(array_length(names) - 1)];
}
