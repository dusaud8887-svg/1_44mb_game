using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class UpgradeUi : MonoBehaviour
{
    public UpgradeScriptableObject Upgrade;

    [SerializeField] private TMP_Text Title;
    [SerializeField] private TMP_Text Description;
    [SerializeField] private Image Icon;
    [SerializeField] private string UpgradeName;
    public List<GameObject> UpgradePointsList;
    // Start is called before the first frame update


    // Update is called once per frame
    void FixedUpdate()
    {

    }


    public void SetInfo(UpgradeScriptableObject info)
    {
        foreach (GameObject go in UpgradePointsList)
        {

            go.transform.GetChild(0).gameObject.SetActive(false);
        }
        Upgrade = info;

        Title.text = Upgrade.Title;
        Description.text = Upgrade.Description;
        Icon.sprite = Upgrade.Icon;
        UpgradeName = Upgrade.name;
        for (int i = 0; i < Upgrade.Points; i++)
        {
            UpgradePointsList[i].transform.GetChild(0).gameObject.SetActive(true);
        }

    }
  public void UpgradeFunction()
    {
        Upgrade.Points++;
        UpgradeManager.Instance .Invoke(Upgrade.Upgarde.ToString(), 0);


  //      UpgradeManager.Instace.CheckForMaxUpgade();

    }
}
