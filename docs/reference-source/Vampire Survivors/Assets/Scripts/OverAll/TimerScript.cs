using UnityEngine;
using TMPro;

public class TimerScript : MonoBehaviour
{
    public TMP_Text timerText;
    private float currentTime = 0.0f;

    public float TimeToWin=600;
    private void Update()
    {
      
     
        currentTime += Time.deltaTime;
        UpdateTimerUI();
        if (currentTime >= TimeToWin)
            GameOver.Instance.GameEnded(true);
    }

    private void UpdateTimerUI()
    {
        // Update the timer text to display the elapsed time
        int minutes = Mathf.FloorToInt(currentTime / 60);
        int seconds = Mathf.FloorToInt(currentTime % 60);

        timerText.text = string.Format("{0:00}:{1:00}", minutes, seconds);
    }
}
