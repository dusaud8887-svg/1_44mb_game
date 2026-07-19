
using UnityEngine;
using TMPro;
using UnityEngine.SceneManagement;
public class GameManager : MonoBehaviour
{
    public static GameManager Instance;

    public bool StopMoveing;
    public bool Pause;
    public TMP_Text TextKill;
    public int NumberOfKills;
    public GameObject Panel;
    public bool CanSpawn;

    private void Awake()
    {
        if (Instance != null)
        {
            Destroy(gameObject);
        }
        else
        {
            Instance = this;
        }
    }

    void Update()
    {
        if(TextKill!=null)
        TextKill.text = NumberOfKills.ToString();
        if (Pause)
        {
            if(Panel!=null)  
               Panel.SetActive(true);
            Time.timeScale = 0;
        }
        else
        {
            if (Panel != null)
                Panel.SetActive(false);
            Time.timeScale = 1;

        }

    }
    public void SelectCharacter(int index)
    {
       DontDestroyOnLoad_.Instance.selectedCharacterIndex = index; // Save the selected character index
        SceneManager.LoadScene(1);
    }
}