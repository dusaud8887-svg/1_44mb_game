using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class UpgradeManager : MonoBehaviour
{
    public static UpgradeManager Instance;

    public List<UpgradeScriptableObject> UpgadeToSpawn;
    public GameObject [] UpgadeUiObject;
    [SerializeField] private GameObject UpgradeObject;
    private List<UpgradeScriptableObject> spawnedUpgades = new List<UpgradeScriptableObject>();
       
    [SerializeField] private GameObject TurretObject;
    [SerializeField] private GameObject OrbsObject;
    [SerializeField] private GameObject PlayerObject;
    [SerializeField] private GameObject PetObject;
    [SerializeField] private GameObject RandomExplosionsObject;
    [SerializeField] private GameObject SwordSlashObject;
    [SerializeField] private GameObject LightningObject;
    [SerializeField] private GameObject KnifeThrowingAbility;
    private void Awake()
    {
        Instance = this;
    }
    private void Start()
    {
        foreach( UpgradeScriptableObject info in UpgadeToSpawn)
        {
            info.Points = 0;
        }
    }

    private void Update()
    {
  
    }
    void Generate()
    {

        int totalSpawnChance = 0;

        // Calculate the total spawn chance for all objects
        foreach (UpgradeScriptableObject spawnInfo in UpgadeToSpawn)
        {
            totalSpawnChance += spawnInfo.Chance;
        }

        // Generate a random value within the total spawn chance
        int randomValue = Random.Range(0, totalSpawnChance);

        // Determine which object should be spawned
        foreach (UpgradeScriptableObject spawnInfo in UpgadeToSpawn)
        {
            if (randomValue < spawnInfo.Chance)
            {
                UpgradeScriptableObject objectToSpawn = spawnInfo;

                // Check if the object has not been spawned before
                if (!spawnedUpgades.Contains(objectToSpawn))
                {

                    UpgadeUiObject[spawnedUpgades.Count].GetComponent<UpgradeUi>().SetInfo(objectToSpawn);
                 //  Debug.Log("Upgade" + objectToSpawn.Title);
                    spawnedUpgades.Add(objectToSpawn);
                    break;
                }
            }
            else
            {
                randomValue -= spawnInfo.Chance;
            }
        }



    }
    public void DisplayUpgrades()
    {
        foreach(UpgradeScriptableObject upgradeInfo in UpgadeToSpawn)
        {
            CheckForMaxUpgade(upgradeInfo);
        }
        UpgradeObject.SetActive(true);
        GameManager.Instance.Pause = true;
        for (int i = 0; i < UpgadeUiObject.Length; i++)
        {        
           Generate();
        }
    }
    public void Close()
    {
        GameManager.Instance.Pause = false;
        //AudioManager.instance.PlaySound("Upgrade");
        UpgradeObject.SetActive(false);
        spawnedUpgades.Clear();
    }
    public void Test()
    {
        Debug.Log("it's working");
    }

    public void ShootProjectile()
    {

        if (TurretObject != null)
        {
            //   TurretObject.SetActive(true);
            TurretObject.GetComponent<Turret>().bulletNumber++;
        }
    }
    public void RandomExplosions()
    {

        if (RandomExplosionsObject != null)
        {
            RandomExplosionsObject.GetComponent<RandomSpawner>().SpawnNumber++;

        }
    }
    public void KnifeProjectile()
    {
        KnifeThrowingAbility.GetComponent<KnifeThrowingAbility>().KnifeCount++;
    }
    public void NewOrb()
    {

        if (OrbsObject != null)
        {
            OrbsObject.GetComponent<Orbs>().orbCount++;
            OrbsObject.GetComponent<Orbs>().SpawnOrbs();
        }

    }
    public void SpawnPet()
    {

        if (PlayerObject != null && PetObject != null)
        {
            GameObject PlayerPet = Instantiate(PetObject, PlayerObject.transform.position, Quaternion.identity);
        }


    }
    public void AddHealth()
    {

        PlayerObject.GetComponent<PlayerHealth>().MaxHealth *= 1.2f;
    }
    public void AddSpeed()
    {
        PlayerStats.Instance.SpeedBonus += 5f;
    }
    public void AddDamge()
    {
        PlayerStats.Instance.DamageBonus += 5f;

    }
    public void Heal()
    {

        PlayerObject.GetComponent<PlayerHealth>().Heal( 50);
    }
    public void AttackSpeed()
    {
        PlayerStats.Instance.AttackSpeedBonnes += 5;

    }
    public void SwordSlash()
    {
        if (SwordSlashObject != null)
            SwordSlashObject.GetComponent<SowrdSlash>().SlashCount++;
    }
    public void ExperienceBonus()
    {
        PlayerStats.Instance.experienceBonus += 5;
    }
    public void LightningBolt()
    {
        if (LightningObject != null)
        {
            //   TurretObject.SetActive(true);
            LightningObject.GetComponent<AbilityLightning>().LightningNumber++;
        }
    }
    public void ExperienceBoost()
    {
        PlayerStats.Instance.experienceBonus += 5;
    }

  public void CheckForMaxUpgade(UpgradeScriptableObject info)
    {   
            if(info.Points == info.MaxPoints)
               UpgadeToSpawn.Remove(info);
    }

}