class AboutSection {
  const AboutSection({
    required this.heading,
    required this.body,
  });

  final String heading;
  final String body;
}

class AboutEntry {
  const AboutEntry({
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.sections,
  });

  final String title;
  final String subtitle;
  final String summary;
  final List<AboutSection> sections;
}

class AboutData {
  static const Map<String, Map<String, AboutEntry>> _data = {
    'About Mawlid': {
      'English': AboutEntry(
        title: 'About Manqoos Mawlid: Shaykh Zainuddin Makhdoom',
        subtitle: 'Ponnani\'s Blessed Heritage, History & Spiritual Legacy',
        summary:
            'Manqoos Mawlid is one of the most beloved, melodious, and beautifully styled panegyrics praising the Prophet Muhammad (peace and blessings be upon him). Composed by the world-renowned Islamic scholar Shaykh Zainuddin Makhdoom I of Ponnani — renowned as the "Makkah of Muslim Kerala" — it stands as an enduring treasure of worship, prophetic remembrance, and solace for millions across Coastal Karnataka, Kerala, and beyond.',
        sections: [
          AboutSection(
            heading: 'Significance & Living Traditions',
            body:
                'Manqoos Mawlid is chanted for worship, spiritual realization, prophetic remembrance, poetic enjoyment, and inner tranquillity. For generations across Karnataka and Kerala, reciting Manqoos Mawlid in moments of joy, gratitude, and difficulty has made it an intimate household tradition.\n\nIt is recited not only on special occasions, but for relief from sickness, solving pressing tribulations, seeking divine abundance (barakah), and prosperity. It is chanted during weddings, foundation laying, housewarming ceremonies, commemoration of the Prophet\'s birth (Milad-un-Nabi), and annual commemorations (Uroos). Across mosques, madrasas, and homes, its melodious cadence resonates continuously throughout the blessed month of Rabi\' al-Awwal through Rabi\' al-Thani 11 (Ghaus al-A\'zam Day).',
          ),
          AboutSection(
            heading: 'Authorship & Origin of the Name "Manqoos"',
            body:
                'Authentic historical consensus confirms that Manqoos Mawlid was authored by the great luminary Shaykh Zainuddin Makhdoom I (r.a.). In Arabic, "Manqoos" (منقوص) signifies "condensed" or "abridged", as the Shaykh meticulously selected core prophetic passages and supplications from earlier classic Mawlid texts.\n\nScholars note strong connections to Imam al-Ghazali\'s (5th century AH Mujaddid) celebrated Subhana Mawlid, from which the verse "Ahya Rabi\'ul Qalbi..." originates, and earlier manuscripts conclude with prayers taught by Imam Ghazali. Others cite the compendium Hujjatullah \'alal \'Alameen by Shaykh Ibn Hajar al-Haytami, abridged by Makhdoom. The historical publication "Makhdoom & Ponnani" by the Ponnani Big Juma Masjid confirms Makhdoom\'s authorship (p. 70). Through his spiritual standing, this work gained widespread fame across India and the Arab world.',
          ),
          AboutSection(
            heading: 'Historical Genesis: The Cholera Epidemic of 910 AH',
            body:
                'In the year 910 AH (1504 CE), Ponnani was struck by an unprecedented catastrophe: a severe outbreak of cholera ("Kalaara") that resulted in massive loss of life, making even funeral preparations and burial rites difficult to manage. Stricken with grief and fear, community leaders approached spiritual master Shaykh Zainuddin Makhdoom I.\n\nIn response, the Shaykh composed this blessed Mawlid specifically for the healing of the people. He instructed them: "Recite this in your homes and feed the poor and needy." The people embraced the counsel, gathering in their homes for recitation and charity. Miraculously, the epidemic lifted, and normal life was swiftly restored. Historian V.M. Abul Hassan Ponnani documents in "Makhdoom Charitre" that from that day forth, reciting Manqoos Mawlid became an established protective tradition against contagious pestilences.',
          ),
          AboutSection(
            heading: 'Historical Testimonies of Healing & Protection',
            body:
                'Even after modern medicine developed, organizing Mawlid gatherings alongside medical care remained a valued spiritual refuge. In 1956–57, when smallpox devastated Eramangalam near Balussery, elders fondly remember the entire village gathering until midnight reciting Manqoos Mawlid through the lanes, after which the disease subsided miraculously.\n\nHistorical chronicles also record that in 894 AH, during the construction of the iconic Ponnani Big Juma Masjid, daunting construction complications arose. Reciting the Tawassul Baith from the conclusion of Manqoos Mawlid brought resolution and success, as documented by Pudiyappila Abdurrahman Musliyar in Ihtida\'un-Nusoos. The text itself explicitly pleads for salvation from epidemics, mentioning "Waba\'a" (pestilence), "Twa\'oon" (plague), "Asqaam" (chronic ailments), and virulent poisons.',
          ),
          AboutSection(
            heading: 'Poetic Radiance & Literary Beauty',
            body:
                'Manqoos Mawlid stands distinct in its combination of linguistic simplicity and intellectual profundity. Its prose and poetry weave succinct phrasing that conveys immense theological depth. The cadence, rhythm, and acoustic melody enchant listeners and scholars alike.\n\nIts opening evokes the historic reception of the Prophet (pbuh) in Madinah ("Tala\'al Badru \'Alayna"): "Subhanalladzi atla\'a fee shahri Rabi\'il Awwali qamara Nabiyyil huda..." (Glory be to Him Who caused the moon of the Prophet of guidance to rise in the month of Rabi\' al-Awwal!). It mirrors the poetry of Hassan ibn Thabit (r.a.) and Imam al-Busiri\'s Burdah, reflecting the Qur\'anic description "Sirajam Muneera" (A Light-giving Lamp).\n\nAmong its most memorable couplets is: "Inna baytan anta sakinuhu / Laysa muhtajan ilas-suruji" ("Indeed, a dwelling in which you reside has no need for lanterns"), echoing the famous narration of Aisha (r.a.) that if a needle fell in the dark chamber where the Prophet (pbuh) sat, she could locate it effortlessly by the radiant luminescence of his blessed face.',
          ),
        ],
      ),
      'Kannada': AboutEntry(
        title: 'ಮಂಕೂಸ್ ಮೌಲಿದ್ (ಮಂಖೂಸ್ ಮೌಲೀದ್) - ಶೈಖ್ ಝೈನುದ್ದೀನ್ ಮಖ್ದೂಮಿ',
        subtitle: 'ಪೊನ್ನಾನಿಯ ಶ್ರೇಷ್ಠ ಕೊಡುಗೆ, ಇತಿಹಾಸ ಹಾಗೂ ಆಧ್ಯಾತ್ಮಿಕ ಹಿನ್ನೆಲೆ',
        summary:
            'ಪ್ರವಾದಿ ಸಲ್ಲಲ್ಲಾಹು ಅಲೈಹಿವಸಲ್ಲಮರ ಮೇಲಿನ ಪ್ರಸಿದ್ಧ ಮೌಲೀದ್‌ಗಳಲ್ಲಿ ಮಂಖೂಸ್ ಮೌಲೀದ್ ಪ್ರಮುಖವಾದದ್ದು. ಇದು ಸರಳ ಸುಂದರ ಶೈಲಿಯಲ್ಲಿರುವ ಮತ್ತು ಸುಶ್ರಾವ್ಯ ಕಂಠದಿಂದ ಪಾರಾಯಣ ಮಾಡಬಹುದಾದ ಹಾಗೂ ಹಾಡಬಹುದಾದ ಸೊಗಸಾದ ಮೌಲೀದ್. ಮುಸ್ಲಿಮ್ ಕೇರಳದ ಮಕ್ಕಾ ಎಂದೇ ಪ್ರಸಿದ್ಧವಾಗಿರುವ ಪೊನ್ನಾನಿಯ ಶ್ರೇಷ್ಠ ಕೊಡುಗೆಗಳಲ್ಲಿ ಇದೂ ಒಂದಾಗಿದೆ. ಲೋಕ ಪ್ರಸಿದ್ಧರಾದ ಶೈಖ್ ಝೈನುದ್ದೀನ್ ಮಖ್ದೂಮಿಯವರು ಈ ಮೌಲೀದನ್ನು ರಚಿಸಿದ್ದಾರೆ.',
        sections: [
          AboutSection(
            heading: 'ಮೌಲೀದ್ ಪಾರಾಯಣದ ಮಹತ್ವ ಹಾಗೂ ಸಂಪ್ರದಾಯ',
            body:
                'ಆರಾಧನೆ, ಆಧ್ಯಾತ್ಮಿಕ ಅನುಭೂತಿ, ಆದರ್ಶ ಪಾಲನೆ, ಪ್ರವಾದಿ ಸಲ್ಲಲ್ಲಾಹು ಅಲೈಹಿವಸಲ್ಲಮರ ದಿವ್ಯ ಸ್ಮರಣೆ, ಕಾವ್ಯಾಸ್ವಾದನೆ ಹಾಗೂ ಆತ್ಮಶಾಂತಿಗಾಗಿ ಪಾರಾಯಣ ಮಾಡುವ ಪುಣ್ಯ ಕೀರ್ತನೆಯಿದು. ಕೇರಳ-ಕರ್ನಾಟಕದ ಮುಸ್ಲಿಮರು ತಮ್ಮ ಸಂತೋಷ, ವಿಶೇಷ, ಸುದಿನ ಹಾಗೂ ಸಂದಿಗ್ಧ ಘಟ್ಟಗಳಲ್ಲಿ ಮಂಖೂಸ್ ಮೌಲೀದನ್ನು ನಿರಂತರವಾಗಿ ಪಾರಾಯಣ ಮಾಡುತ್ತಾ ಬರುತ್ತಿರುವುದರಿಂದ ಅದು ಅವರ ಸ್ವಂತ ಮೌಲೀದಾಗಿ ಮಾರ್ಪಟ್ಟಿದೆ.\n\nವಿಶೇಷ ಸಂದರ್ಭಗಳಲ್ಲಿ ಮಾತ್ರವಲ್ಲ; ಸಮಸ್ಯೆಗಳ ಪರಿಹಾರಕ್ಕೆ, ರೋಗ ಶಮನಕ್ಕೆ, ಅನುಗ್ರಹಗಳಿಗಾಗಿ, ಐಶ್ವರ್ಯ ಪ್ರಾಪ್ತಿಗೆ ಇನ್ನೂ ಅನೇಕ ಕಾರಣಗಳಿಗಾಗಿ ಮಂಖೂಸ್ ಮೌಲೀದ್ ಪಾರಾಯಣ ಮಾಡುತ್ತಾರೆ. ವಿವಾಹ, ಮನೆ ನಿರ್ಮಾಣ, ಗೃಹ ಪ್ರವೇಶ, ಮರಣಾನಂತರ ಕರ್ಮಗಳು, ಮೀಲಾದುನ್ನಬೀ, ಉರೂಸ್ ಮೊದಲಾದ ಸಂದರ್ಭಗಳಲ್ಲಿ ಈ ಮೌಲೀದನ್ನು ಹೆಚ್ಚು ಪಾರಾಯಣ ಮಾಡಲಾಗುತ್ತದೆ. ಮುಸ್ಲಿಮ್ ಮನೆಗಳಲ್ಲಿ, ಮಸೀದಿ, ಮದ್ರಸ ಹಾಗೂ ಸಂಸ್ಥೆಗಳಲ್ಲಿ ರಬೀಉಲ್ ಅವ್ವಲ್ ಒಂದರಿಂದ ಹಿಡಿದು ರಬೀಉಲ್ ಆಖಿರ್ ೧೧ನೇ (ಜೀಲಾನಿ ದಿನ) ದಿನದ ವರೆಗೆ ಎಲ್ಲಾ ದಿನಗಳಲ್ಲೂ ಈ ಮೌಲೀದ್ ಆಲಾಪನೆ ಮಾಡಲಾಗುತ್ತದೆ.',
          ),
          AboutSection(
            heading: 'ರಚನೆಗಾರರು ಮತ್ತು "ಮಂಖೂಸ್" ಎಂಬ ಹೆಸರಿನ ಹಿನ್ನೆಲೆ',
            body:
                'ಮಂಖೂಸ್ ಮೌಲೀದನ್ನು ಪ್ರಖ್ಯಾತ ವಿದ್ವಾಂಸರಾದ ಒಂದನೇ ಶೈಖ್ ಝೈನುದ್ದೀನ್ ಮಖ್‌ದೂಂ (ರ) ರಚಿಸಿದ್ದಾರೆಂಬುದು ಪ್ರಬಲ ಅಭಿಪ್ರಾಯ. "ಮಂಖೂಸ್" ಎಂಬ ಹೆಸರಿನ ಅರ್ಥ "ಸಂಕ್ಷಿಪ್ತಗೊಳಿಸಲ್ಪಟ್ಟದ್ದು" ಎಂದು. ಆ ಕಾಲದಲ್ಲಿ ಪ್ರಚಾರದಲ್ಲಿದ್ದ ಪ್ರಮುಖ ಮೌಲೀದ್ ಗ್ರಂಥಗಳಿಂದ ಸಂಗ್ರಹಿಸಿ ಈ ಮೌಲೀದನ್ನು ರಚಿಸಲಾಗಿದೆ. ಆದ್ದರಿಂದ ಈ ಮೌಲೀದ್‌ಗೆ "ಮಂಖೂಸ್" ಎಂದು ಹೆಸರು ಬಂತು.\n\nಐದನೇ ಶತಮಾನದ ಮುಜದ್ದಿದ್, ವಿಶ್ವ ಪ್ರಸಿದ್ಧ ವಿದ್ವಾಂಸ ಇಮಾಂ ಗಝ್ಝಾಲಿ(ರ)ಯವರ ಸುಬ್‌ಹಾನ ಮೌಲೀದ್‌ನ ಸಂಗ್ರಹ ಇದು ಎಂಬ ಅಭಿಪ್ರಾಯವೂ ಇದೆ. "ಅಹ್‌ಯಾ ರಬೀವುಲ್ ಖಲ್‌ಬಿ..." ಎಂಬ ಪದ್ಯವನ್ನು ಸುಬ್‌ಹಾನ ಮೌಲೀದ್‌ನಿಂದ ತೆಗೆದುಕೊಳ್ಳಲಾಗಿದೆ. ಮಂಖೂಸ್‌ನ ಹಳೆಯ ಪ್ರತಿಗಳ ಕೊನೆಯ ಭಾಗದಲ್ಲಿ ಇಮಾಂ ಗಝ್ಝಾಲಿ(ರ) ಹೇಳಿಕೊಟ್ಟ ಪ್ರಾರ್ಥನೆಯ ಸಾಲುಗಳಿತ್ತು. ಹಾಗೆಯೇ ಪ್ರಸಿದ್ಧ ವಿದ್ವಾಂಸರಾದ ಇಬ್ನ್ ಹಜರುಲ್ ಹೈತಮಿ(ರ)ಯವರ "ಹುಜ್ಜತುಲ್ಲಾಹಿ ಅಲಲ್ ಆಲಮೀನ್" ಗ್ರಂಥವನ್ನು ಅವರ ಶಿಷ್ಯರಾದ ಝೈನುದ್ದೀನ್ ಮಖ್‌ದೂಂ ಸಂಕ್ಷಿಪ್ತಗೊಳಿಸಿ ಸಂಗ್ರಹಿಸಿದರೆಂಬ ಅಭಿಪ್ರಾಯವೂ ಇದೆ. ಪೊನ್ನಾನಿ "ಜುಮುಅತ್ ಪಳ್ಳಿ" ಪರಿಪಾಲನಾ ಕಮಿಟಿ ಪ್ರಕಟಿಸಿದ "ಮಖ್‌ದೂಂ ಹಾಗೂ ಪೊನ್ನಾನಿ" ಎಂಬ ಗ್ರಂಥದಲ್ಲೂ ಇದು ಸ್ಪಷ್ಟವಾಗಿದೆ (ಪುಟ ೭೦). ಕೇರಳ, ಕರ್ನಾಟಕ ಮಾತ್ರವಲ್ಲ; ಭಾರತದ ವಿವಿಧ ಭಾಗಗಳು ಮತ್ತು ಅರೇಬಿಯಾದಲ್ಲೂ ಮಂಖೂಸ್ ಮೌಲೀದ್‌ನ ಆಲಾಪನೆ ನಡೆಯುತ್ತದೆ.',
          ),
          AboutSection(
            heading: 'ರಚನೆಯ ಚಾರಿತ್ರಿಕ ಹಿನ್ನೆಲೆ: ಕಾಲಾರ ರೋಗ ಶಮನ',
            body:
                'ಹಿಜ್‌ರಿ ೯೧೦ರಲ್ಲಿ ಪೊನ್ನಾನಿಯು ಒಂದು ದುರಂತಕ್ಕೆ ಸಾಕ್ಷಿಯಾಯಿತು. "ಕಾಲಾರ" ಎಂಬ ಮಹಾಮಾರಿ ಈ ಊರಿಗೆ ದಾಳಿಯಿಟ್ಟು ಅನೇಕರ ಮರಣಕ್ಕೆ ಕಾರಣವಾಯಿತು. ಈ ಸಾಮೂಹಿಕ ಮರಣವು ಮಯ್ಯತ್ ಸಂಸ್ಕಾರವೂ ಕಷ್ಟವಾಗುವಷ್ಟು ದಾರುಣವಾಗಿತ್ತು. ಭಯವಿಹ್ವಲರಾದ ಜನರು ಆಗಿನ ಪ್ರಮುಖ ಆಧ್ಯಾತ್ಮಿಕ ನೇತಾರರಾಗಿದ್ದ ಒಂದನೇ ಮಖ್‌ದೂಮ್‌ರವರನ್ನು ಭೇಟಿಯಾಗಿ ತಮ್ಮ ದುಃಖವನ್ನು ತೋಡಿಕೊಂಡರು.\n\nಆ ಸಂದರ್ಭದಲ್ಲಿ ಝೈನುದ್ದೀನ್ ಮಖ್‌ದೂಂ ಜನರ ರೋಗ ಶಮನಕ್ಕಾಗಿ ಈ ಗ್ರಂಥವನ್ನು ರಚಿಸಿಕೊಟ್ಟರು. "ಇದನ್ನು ನಿಮ್ಮ ಮನೆಗಳಲ್ಲಿ ಪಾರಾಯಣ ಮಾಡಿ, ಬಡ ಜನರಿಗೆ ಊಟ ಹಾಕಿ" ಎಂದು ಹೇಳಿ ಕಳುಹಿಸಿದರು. ಜನರು ಆ ಗ್ರಂಥವನ್ನು ಸ್ವೀಕರಿಸಿ ಮನೆಗಳಲ್ಲಿ ಪಾರಾಯಣ ಮಾಡತೊಡಗಿದರು. ಪರಿಣಾಮ ಕಾಲಾರ ಎಂಬ ಮಹಾಮಾರಿ ಆ ಊರನ್ನು ತೊರೆಯಿತು. ಜನಜೀವನವು ಅತಿ ವೇಗವಾಗಿ ಸಾಮಾನ್ಯ ಸ್ಥಿತಿಗೆ ಮರಳಿತು. ಅಂದಿನಿಂದ ಸಾಂಕ್ರಾಮಿಕ ರೋಗ, ಮಾರಕ ಕಾಯಿಲೆಗಳು ಬಂದರೆ ಮಂಖೂಸ್ ಮೌಲೀದ್ ಪಾರಾಯಣ ಮಾಡುವುದು ಒಂದು ಸಂಪ್ರದಾಯವಾಯಿತು ಎಂದು "ಮಖ್‌ದೂಂ ಚರಿತ್ರೆ" ಕೃತಿಯಲ್ಲಿ ವಿ.ಎಂ. ಅಬುಲ್ ಹಸನ್ ಪೊನ್ನಾನಿ ದಾಖಲಿಸಿದ್ದಾರೆ.',
          ),
          AboutSection(
            heading: 'ಚಾರಿತ್ರಿಕ ಸಾಕ್ಷ್ಯಗಳು ಮತ್ತು ರೋಗ ನಿವಾರಣೆಯ ಅದ್ಭುತ ಘಟನೆಗಳು',
            body:
                'ಮುಂದೆ ವೈದ್ಯಕೀಯ ಚಿಕಿತ್ಸೆ ವ್ಯಾಪಕವಾದ ಮೇಲೂ ಲೌಕಿಕ ಚಿಕಿತ್ಸೆಯೊಂದಿಗೆ ಮೌಲೀದ್ ಸಭೆಗಳನ್ನು ಆಯೋಜಿಸುವುದು ಸಾರ್ವತ್ರಿಕವಾಯಿತು. ೧೯೫೬-೫೭ರ ಕಾಲಘಟ್ಟದಲ್ಲಿ ಬಾಲುಶ್ಶೇರಿಯ ಸಮೀಪದ ಎರಮಂಗಲಂ ಎಂಬ ಪ್ರದೇಶದಲ್ಲಿ ಸಿಡುಬು ರೋಗ ಬಾಧಿಸಿ ಅನೇಕ ಮಂದಿ ಮರಣ ಹೊಂದಿದರು. ಊರಿನ ಜನರು ಒಂದಾಗಿ ಮಂಖೂಸ್ ಮೌಲೀದ್ ಓದುತ್ತಾ ಮಧ್ಯರಾತ್ರಿಯವರೆಗೂ ಊರು ಸುತ್ತಿದಾಗ ರೋಗ ಶಮನವಾದ ಅದ್ಭುತ ಘಟನೆಯನ್ನು ಆ ಊರಿನ ವೃದ್ಧರು ಇಂದಿಗೂ ಮರೆತಿಲ್ಲ.\n\nಹಿಜ್‌ರಿ ೮೯೪ರಲ್ಲಿ ಪೊನ್ನಾನಿಯ ದೊಡ್ಡ ಜುಮುಅತ್ತ್ ಮಸೀದಿ ನಿರ್ಮಾಣದ ಸಂದರ್ಭದಲ್ಲಿ ಎದುರಾದ ಸಮಸ್ಯೆಗಳಿಗೆ ಮಂಖೂಸ್ ಮೌಲೀದ್‌ನ ಕೊನೆಯ ಭಾಗದಲ್ಲಿರುವ ತವಸ್ಸುಲ್ ಬೈತನ್ನು ಹೇಳಿ ಪ್ರಾರ್ಥಿಸಿದಾಗ ಪರಿಹಾರವಾಯಿತು ಎಂದು ಪುದಿಯಾಪ್ಪಿಳ ಅಬ್ದುರ್ರಹ್ಮಾನ್ ಮುಸ್ಲಿಯಾರ್ ಉಲ್ಲೇಖಿಸಿದ್ದಾರೆ (ಇಹ್‌ತಿದಾಉನ್ನುಸ್ಸೂಸ್ ಅಲಾ ಖಿರಾಅತಿಲ್ ಮಂಖೂಸ್, ಪು: ೨). ಗಂಭೀರವಾದ ಸಮಸ್ಯೆಗಳ ನಿವಾರಣೆಗಾಗಿ ಮೌಲೀದ್‌ನಲ್ಲಿರುವ "ಖದ್ ಹಲ್ಲ ಬೀ ಮಾಖದ್ ಅಲಿಂತ ಮಿನಲ್ ಅದಾ..." ಮತ್ತು ಪ್ರಾರ್ಥನೆಯಲ್ಲಿ ಬರುವ "ವಬಾಅ್, ತ್ವಾಊನ್, ಅಸ್‌ಖಾಂ, ಹಾದ ಸ್ಸುಮ್ಮನ್ನಾಖಿಅ್" ನಂತಹ ರೋಗಗಳ ಹೆಸರುಗಳ ಉಲ್ಲೇಖ ಇದಕ್ಕೆ ಸಾಕ್ಷಿಯಾಗಿದೆ.',
          ),
          AboutSection(
            heading: 'ಕಾವ್ಯಾತ್ಮಕ ಸೌಂದರ್ಯ ಹಾಗೂ ಸಾಹಿತ್ಯಿಕ ಶ್ರೀಮಂತಿಕೆ',
            body:
                'ಮಂಖೂಸ್ ಮೌಲೀದ್ ಸರಳ ಭಾಷೆ ಹಾಗೂ ವೈಚಾರಿಕ ಶ್ರೀಮಂತಿಕೆಯನ್ನು ಹೊಂದಿದೆ. ಗದ್ಯ ಮತ್ತು ಪದ್ಯಗಳೆರಡರಲ್ಲೂ ಸಣ್ಣ ಸಣ್ಣ ಪದಪ್ರಯೋಗಗಳು ದೊಡ್ಡ ವಿಚಾರಗಳನ್ನು ಒಳಗೊಂಡಿವೆ. ಪದ್ಯ ಮತ್ತು ಗದ್ಯಗಳಲ್ಲಿ ಮಿಳಿತವಾಗಿರುವ ಕಾವ್ಯಾತ್ಮಕತೆ, ಲಯ ಮತ್ತು ತಾಳ ಅತ್ಯಂತ ಆಕರ್ಷಕವಾಗಿದೆ.\n\nಮಂಖೂಸ್ ಮೌಲೀದಿನ ಆರಂಭವು ಪ್ರವಾದಿ (ಸ.ಅ)ರನ್ನು ಮದೀನಕ್ಕೆ ಸ್ವಾಗತಿಸಿ ಹಾಡಿದ "ತ್ವಲಅಲ್ ಬದ್‌ರು ಅಲೈನಾ..." (ನಮ್ಮಲ್ಲಿ ಪೂರ್ಣ ಚಂದ್ರನು ಉದಯಿಸಿದನು) ಎಂಬ ಹಾಡನ್ನು ನೆನಪಿಸುತ್ತದೆ: "ಸುಬ್‌ಹಾನಲ್ಲದ್ಸೀ ಅತ್ಲಅ ಫೀ ಶಹ್ರಿ ರಬೀಇಲ್ ಅವ್ವಲಿ ಖಮರ ನಬಿಯ್ಯಿಲ್ ಹುದಾ..." (ರಬೀಉಲ್ ಅವ್ವಲ್‌ನಲ್ಲಿ ಸನ್ಮಾರ್ಗದ ಪ್ರವಾದಿಯನ್ನು ಉದಯಿಸಿದ ಅಲ್ಲಾಹನು ಎಷ್ಟು ಪರಿಶುದ್ಧನು!). ಪ್ರವಾದಿಯ ಆಪ್ತ ಕವಿ ಹಸ್ಸಾನುಬ್ನು ಸಾಬಿತ್(ರ) ಹಾಗೂ ವಿಶ್ವಕವಿ ಇಮಾಂ ಬೂಸ್ವಿರಿ(ರ)ಯವರ ಬುರ್ದಾದಂತೆ, ಪ್ರವಾದಿಯವರನ್ನು ಪೂರ್ಣಚಂದ್ರ ಹಾಗೂ ಕುರ್‌ಆನ್ ವರ್ಣಿಸಿದ "ಸಿರಾಜುನ್ ಮುನೀರ್" (ಪ್ರಕಾಶಿಸುವ ದೀಪ) ಎಂದು ಬಣ್ಣಿಸಲಾಗಿದೆ.\n\n"ಇನ್ನ ಬೈತನ್ ಅಂತ ಸಾಕಿನುಹು / ಲೈಸ ಮುಹ್ತಾಜನ್ ಇಲಸ್ಸುರುಜಿ" (ತಾವು ವಾಸಿಸುವ ಭವನಕ್ಕೆ ಬೆಳಕಿನ ಅಗತ್ಯವಿಲ್ಲ) ಎಂಬ ಸಾಲು ಪ್ರವಾದಿ (ಸ.ಅ) ಅವರ ದಿವ್ಯಜ್ಞಾನ ಹಾಗೂ ತೇಜಸ್ಸನ್ನು ವರ್ಣಿಸುತ್ತದೆ. ಪ್ರವಾದಿ ಸಲ್ಲಲ್ಲಾಹು ಅಲೈಹಿವಸಲ್ಲಮರು ವಾಸಿಸುವ ಕೋಣೆಯಲ್ಲಿ ಸೂಜಿ ಬಿದ್ದರೂ ಬೆಳಕಿನ ಅಗತ್ಯವಿಲ್ಲದೆಯೇ ಕಾರಿರುಳಲ್ಲಿ ಹುಡುಕಿ ತೆಗೆಯಬಹುದಿತ್ತು ಎಂದು ಆಯಿಶಾ (ರ) ಹೇಳಿದ್ದಾರೆ. ಪ್ರವಾದಿಯವರ ಮುಖವು ಸೂರ್ಯನಂತೆ ತೇಜೋಪೂರ್ಣವಾಗಿ ಹೊಳೆಯುತ್ತಿತ್ತು ಎಂದು ಅನುಚರರು ಬಣ್ಣಿಸಿದ್ದಾರೆ.',
          ),
        ],
      ),
    },

    'About App': {
      'English': AboutEntry(
        title: 'About Manqoos Mawlid App',
        subtitle: 'Credits & Highlights',
        summary:
            'A lightweight, offline digital reader for Manqoos Mawlid featuring authentic Arabic typography, line-by-line translations, and offline audio recitations.',
        sections: [
          AboutSection(
            heading: 'Translations',
            body:
                '• Kannada Translation: Noufal Marzuqi Malar\n• English Translation: Shafeeq Hudawi',
          ),
          AboutSection(
            heading: 'Recitations',
            body:
                '• Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi\n• Arif Sa\'adi Katipalla',
          ),
          AboutSection(
            heading: 'Key Features',
            body:
                '• Line-by-line translation and verse explanation\n• Original Arabic Mushaf page view\n• Offline audio playback with reciter selection\n• 3-level adjustable font sizes',
          ),
        ],
      ),
      'Kannada': AboutEntry(
        title: 'ಆ್ಯಪ್ ವಿವರ (About App)',
        subtitle: 'ಅನುವಾದಕರು, ಓದುಗರು ಹಾಗೂ ವೈಶಿಷ್ಟ್ಯಗಳು',
        summary:
            'ಮಂಕೂಸ್ ಮೌಲಿದ್ ಅನ್ನು ಸುಲಭವಾಗಿ ಓದಲು, ಕೇಳಲು ಮತ್ತು ಕಲಿಯಲು ರೂಪಿಸಲಾದ ಸರಳ ಹಾಗೂ ಸಂಪೂರ್ಣ ಆಫ್‌ಲೈನ್ ಡಿಜಿಟಲ್ ಆ್ಯಪ್.',
        sections: [
          AboutSection(
            heading: 'ಅನುವಾದಕರು (Translations)',
            body:
                '• ಕನ್ನಡ ಅನುವಾದ: ನೌಫಲ್ ಮರ್ಝೂಖಿ ಮಲಾರ್ (Noufal Marzuqi Malar)\n• ಇಂಗ್ಲಿಷ್ ಅನುವಾದ: ಶಫೀಖ್ ಹುದವಿ (Shafeeq Hudawi)',
          ),
          AboutSection(
            heading: 'ಓದುಗರು (Reciters)',
            body:
                '• ಸಯ್ಯಿದ್ ತಾಹಾ ತಂಙಳ್ ಪೂಕ್ಕೊಟ್ಟೂರ್ / ಹಾಫಿಜ್ ನಿಜಾಮುದ್ದೀನ್ ಮಹ್ಮೂದಿ\n• ಆರಿಫ್ ಸಅದಿ ಕಟಿಪಳ್ಳ',
          ),
          AboutSection(
            heading: 'ಪ್ರಮುಖ ವೈಶಿಷ್ಟ್ಯಗಳು',
            body:
                '• ಸಾಲು-ಸಾಲಿನ ಕನ್ನಡ ಮತ್ತು ಇಂಗ್ಲಿಷ್ ಅನುವಾದ ಹಾಗೂ ವಿವರಣೆ\n• ಮೂಲ ಅರಬಿ ಪುಟಗಳ ವೀಕ್ಷಣೆ\n• ಆಫ್‌ಲೈನ್ ಆಡಿಯೋ ಪ್ಲೇಯರ್\n• 3 ಹಂತದ ಅಕ್ಷರ ಗಾತ್ರ ಹೊಂದಾಣಿಕೆ',
          ),
        ],
      ),
    },

    'About Us': {
      'English': AboutEntry(
        title: 'About Islamic Way Team',
        subtitle: 'The Solution for Humanity',
        summary:
            'Islamic way team is an ensemble of some like minded youths converged on a common aim of promulgating the message of Islam as accessible to all seekers irrespective of their ideological basis. Our team is diligent online and offline in serving this founding goal. Though we are not of a big claims in this regard, we are grateful to Almighty on being fortune to do some Dawa activities.\n\nThis is the fruit of well awaited endeavour of IWT to make the intact meaning of Holy Quran adhering to its pristine purity as explained by the great-souled Sahabas and Imams accessible to general mass. This app features various recitations too. Asking only the heart felt supplications for the acceptance of this venture by Allah SWT and also for the prosperity and tranquility of those who initiated this project and those who dedicated their times and pennys for the same in here and hereafter, we are happy keep this app before all kannadigas.',
        sections: [],
      ),
      'Kannada': AboutEntry(
        title: 'ಇಸ್ಲಾಮಿಕ್ ವೇ ತಂಡ (ನಮ್ಮ ಬಗ್ಗೆ)',
        subtitle: 'ಮಾನವಕುಲಕ್ಕೆ ಶಾಶ್ವತ ಪರಿಹಾರ',
        summary:
            'ಇಸ್ಲಾಮಿಕ್ ವೇ ತಂಡವು ಕೆಲವು ಸಮಾನ ಮನಸ್ಕ ಯುವಕರ ಸಮೂಹವಾಗಿದ್ದು, ಇಸ್ಲಾಂ ಧರ್ಮದ ಸಂದೇಶವನ್ನು ಅವರ ಸೈದ್ಧಾಂತಿಕ ಆಧಾರವನ್ನು ಲೆಕ್ಕಿಸದೆ ಎಲ್ಲಾ ಅನ್ವೇಷಕರಿಗೆ ಪ್ರವೇಶಿಸಬಹುದು ಎಂದು ಪ್ರಚಾರ ಮಾಡುವ ಸಾಮಾನ್ಯ ಗುರಿಯೊಂದಿಗೆ ಒಮ್ಮುಖವಾಗಿದೆ. ಈ ಸ್ಥಾಪಕ ಗುರಿಯನ್ನು ಪೂರೈಸುವಲ್ಲಿ ನಮ್ಮ ತಂಡ ಆನ್‌ಲೈನ್ ಮತ್ತು ಆಫ್‌ಲೈನ್‌ನಲ್ಲಿ ಶ್ರದ್ಧೆಯಿಂದ ಕೆಲಸ ಮಾಡುತ್ತದೆ. ಈ ವಿಷಯದಲ್ಲಿ ನಾವು ದೊಡ್ಡ ಹಕ್ಕುಗಳನ್ನು ಹೊಂದಿಲ್ಲವಾದರೂ, ಕೆಲವು ದಾವಾ ಚಟುವಟಿಕೆಗಳನ್ನು ಮಾಡುವ ಅದೃಷ್ಟವನ್ನು ಹೊಂದಿದ್ದಕ್ಕಾಗಿ ನಾವು ಸರ್ವಶಕ್ತನಿಗೆ ಕೃತಜ್ಞರಾಗಿರುತ್ತೇವೆ.',
        sections: [],
      ),
    },

    'Q&A': {
      'English': AboutEntry(
        title: 'Questions & Answers',
        subtitle: 'Clarifications & Common Inquiries',
        summary:
            'Helpful answers to common questions regarding Manqoos Mawlid, recitation etiquette, and application features.',
        sections: [
          AboutSection(
            heading: 'Q1: What is the meaning of "Manqoos"?',
            body:
                'A: In Arabic, "Manqoos" (منقوص) literally means shortened, condensed, or selected. Shaykh Zainuddin Makhdoom compiled this work concisely so it could be easily recited by the community in times of need and daily gatherings.',
          ),
          AboutSection(
            heading: 'Q2: How do I switch between Kannada and English?',
            body:
                'A: Navigate to Settings (from the bottom navigation bar or the home screen) and select your preferred language under "Translation language". The reader and about sections will update immediately.',
          ),
          AboutSection(
            heading: 'Q3: How do I change font size?',
            body:
                'A: Go to Settings and choose your preferred size under "Translation font size": Small, Medium, or Large. This adjusts translation and explanation text without changing Arabic calligraphy.',
          ),
          AboutSection(
            heading: 'Q4: How do I listen to the audio recitation?',
            body:
                'A: Tap the Play button on the bottom bar of the Mawlid reader, or select your preferred reciter from the Reciter screen. The audio continues playing seamlessly as you scroll.',
          ),
          AboutSection(
            heading: 'Q5: How do I view original Arabic pages without translation?',
            body:
                'A: In Settings, toggle "Show translation" to OFF. Opening Mawlid will now display full Arabic calligraphy pages.',
          ),
        ],
      ),
      'Kannada': AboutEntry(
        title: 'ಪ್ರಶ್ನೋತ್ತರಗಳು (Q&A)',
        subtitle: 'ಸಾಮಾನ್ಯ ಪ್ರಶ್ನೆಗಳು ಮತ್ತು ಸ್ಪಷ್ಟೀಕರಣಗಳು',
        summary:
            'ಮಂಕೂಸ್ ಮೌಲಿದ್, ಅದರ ಪಠಣ ಹಾಗೂ ಆ್ಯಪ್ ಬಳಕೆಗೆ ಸಂಬಂಧಿಸಿದ ಮುಖ್ಯ ಪ್ರಶ್ನೆಗಳು ಮತ್ತು ಉತ್ತರಗಳು.',
        sections: [
          AboutSection(
            heading: 'ಪ್ರಶ್ನೆ ೧: "ಮಂಕೂಸ್" ಎಂದರೇನು?',
            body:
                'ಉತ್ತರ: ಅರಬಿಯಲ್ಲಿ "ಮಂಕೂಸ್" ಎಂದರೆ ಸಂಕ್ಷಿಪ್ತಗೊಳಿಸಲಾದ ಅಥವಾ ಆಯ್ದ ಭಾಗ ಎಂದರ್ಥ. ಓದಲು ಸುಲಭವಾಗುವಂತೆ ಮತ್ತು ಪ್ರಮುಖ ಪ್ರಾರ್ಥನೆಗಳನ್ನು ಒಂದೆಡೆ ಸೇರಿಸಿ ಇದನ್ನು ಸಂಕ್ಷಿಪ್ತವಾಗಿ ರಚಿಸಲಾಗಿದೆ.',
          ),
          AboutSection(
            heading: 'ಪ್ರಶ್ನೆ ೨: ಕನ್ನಡ ಮತ್ತು ಇಂಗ್ಲಿಷ್ ಅನುವಾದವನ್ನು ಹೇಗೆ ಬದಲಾಯಿಸುವುದು?',
            body:
                'ಉತ್ತರ: ಸೆಟ್ಟಿಂಗ್ಸ್ (Settings) ಪುಟಕ್ಕೆ ತೆರಳಿ "Translation language" ಆಯ್ಕೆಯಲ್ಲಿ ಕನ್ನಡ ಅಥವಾ English ಆಯ್ಕೆ ಮಾಡಿಕೊಳ್ಳಿ.',
          ),
          AboutSection(
            heading: 'ಪ್ರಶ್ನೆ ೩: ಅಕ್ಷರಗಳ ಗಾತ್ರವನ್ನು ಹೇಗೆ ಹೆಚ್ಚಿಸುವುದು?',
            body:
                'ಉತ್ತರ: ಸೆಟ್ಟಿಂಗ್ಸ್ ಪುಟದಲ್ಲಿ "ಅಕ್ಷರ ಗಾತ್ರ" (Translation font size) ವಿಭಾಗದಲ್ಲಿ ಸಣ್ಣ, ಮಧ್ಯಮ ಅಥವಾ ದೊಡ್ಡ (Small, Medium, Large) ಆಯ್ಕೆಗಳಲ್ಲಿ ನಿಮ್ಮಿಷ್ಟದ ಗಾತ್ರವನ್ನು ಆರಿಸಿಕೊಳ್ಳಬಹುದು.',
          ),
          AboutSection(
            heading: 'ಪ್ರಶ್ನೆ ೪: ಮೌಲಿದ್ ಆಡಿಯೋವನ್ನು ಹೇಗೆ ಆಲಿಸುವುದು?',
            body:
                'ಉತ್ತರ: ಮೌಲಿದ್ ಓದುವ ಪುಟದ ಕೆಳಭಾಗದಲ್ಲಿರುವ Play ಬಟನ್ ಒತ್ತಿ ಆಲಿಸಬಹುದು, ಅಥವಾ Reciter ಪುಟಕ್ಕೆ ಹೋಗಿ ನಿಮ್ಮ ನೆಚ್ಚಿನ ಓದುಗರನ್ನು ಆರಿಸಿಕೊಳ್ಳಬಹುದು.',
          ),
          AboutSection(
            heading: 'ಪ್ರಶ್ನೆ ೫: ಕೇವಲ ಅರಬಿ ಪುಟಗಳನ್ನು ಮಾತ್ರ ಓದುವುದು ಹೇಗೆ?',
            body:
                'ಉತ್ತರ: ಸೆಟ್ಟಿಂಗ್ಸ್ ಪುಟದಲ್ಲಿ "Show translation" ಆಯ್ಕೆಯನ್ನು ಆಫ್ (Off) ಮಾಡಿದರೆ ಕೇವಲ ಅರಬಿ ಪುಟಗಳ ರೀಡರ್ ತೆರೆದುಕೊಳ್ಳುತ್ತದೆ.',
          ),
        ],
      ),
    },
  };

  static AboutEntry get(String title, String language) {
    final titleData = _data[title] ?? _data['About Mawlid']!;
    final langKey = language.toLowerCase() == 'kannada' ? 'Kannada' : 'English';
    return titleData[langKey] ?? titleData['English']!;
  }
}
